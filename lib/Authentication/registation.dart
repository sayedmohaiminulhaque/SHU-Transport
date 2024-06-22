import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_map_live/Admin/admin.dart';
import '../widgets.dart';
import 'authService.dart';

class StudentRegi extends StatefulWidget {
  const StudentRegi({Key? key}) : super(key: key);
  @override
  State<StudentRegi> createState() => _StudentRegiState();
}

class _StudentRegiState extends State<StudentRegi> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  String valD="";
  String session="";
  String mobile="";

  AuthService authService = AuthService();

  List listItem = [ "Admin", "Teacher","Student","Staff","Driver" ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: _isLoading
          ? Center(
          child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor))
          : SingleChildScrollView(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Transport",
                    style: TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                      "Create your account now know the bus location",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400)),
                  Image.asset("Image/bus.png"),
                  TextFormField(                                                            // SignUp full name
                    decoration: textInputDecoration.copyWith(
                        labelText: "Full Name",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                        )),
                    onChanged: (val) {
                      setState(() {
                        fullName = val;
                      });
                    },
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      } else {
                        return "Name cannot be empty";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(                                              // SignUp  Email
                    decoration: textInputDecoration.copyWith(
                        labelText: "Email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Theme.of(context).primaryColor,
                        ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },

                    // check tha validation
                    validator: (val) {
                      return RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val!)
                          ? null
                          : "Please enter a valid email";
                    },
                  ),
                  const SizedBox(height: 10),

                  DropdownButtonFormField(                                              // Dropdown Menu
                    value: valD.isNotEmpty?valD:null,
                    onChanged: (newValue){
                      setState(() {
                        valD = newValue as String ;
                      });
                    },
                    items: listItem.map((valItem){
                      return DropdownMenuItem(
                        value: valItem,
                        child: Text(valItem),
                      );
                    }).toList(),
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.lightBlueAccent,
                    ),
                    dropdownColor: Colors.white,
                    decoration: textInputDecoration.copyWith(
                      labelText: "Status",
                      prefixIcon: Icon(
                        Icons.bookmark_add_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  TextFormField(                                                            // MObile
                    decoration: textInputDecoration.copyWith(
                        labelText: "Mobile",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                        )),
                    onChanged: (val) {
                      setState(() {
                        mobile = val;
                      });
                    },
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      } else {
                        return "Mobile cannot be empty";
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  TextFormField(                                                      // SignUp  Password
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(
                        labelText: "Password",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Theme.of(context).primaryColor,
                        )),
                    validator: (val) {
                      if (val!.length < 6) {
                        return "Password must be at least 6 characters";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        "Register",
                        style:
                        TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        stregister();                             // ----->>>>  Registration Page
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            AdminPanel()));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),


                ],
              )),
        ),
      ),
    );
  }


  stregister() async {
    if(valD == "Driver"){
      await FirebaseFirestore.instance.collection("driverList").doc(email).set({
        'name': fullName,
        'mobile': mobile
      });
    }
    try{
      if (formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });
        await authService
            .registerUserWithEmailandPassword(fullName, email,valD,mobile, password)
            .then((value) async {
          if (value == true) {
            // saving the shared preference state
            await HelperFunctions.saveUserLoggedInStatus(true);
            await HelperFunctions.saveUserEmailSF(email);
            await HelperFunctions.saveUserNameSF(fullName);
            showToast("Succesfully Signed Up");

          } else {
            showSnackbar(context, Colors.red, value);
            setState(() {
              _isLoading = false;
            });
          }
        });
      }
    }on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        showToast("Password Provided Weak");
      }else if(e.code == 'email-already-in-use'){
        showToast("Email Provided already Exists");
      }
    }catch(e){
      showToast(e.toString());
    }


  }


}

