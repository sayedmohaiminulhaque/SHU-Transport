import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_live/Admin/admin.dart';
import 'package:google_map_live/Authentication/authService.dart';
import 'package:google_map_live/Authentication/forgotPassword.dart';
import 'package:google_map_live/Authentication/registation.dart';
import 'package:google_map_live/home.dart';
import 'package:google_map_live/main.dart';
import '../Driver/driverInterface.dart';
import '../widgets.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isloading = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: ()=> _onBackButtonPressed(context),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
                children:[
                  Container(
                    height: MediaQuery.of(context).size.height*0.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white
                    ),
                    child: Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                          )
                      ),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           /* Image.asset("Image/bus1.png"),
                            SizedBox(height:60,),*/
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 12.0),
                              child: Text("Welcome to",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25.0,
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 12.0),
                              child: Text("SHU Transport",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                ),
                              ),
                            ),
                            Container(
                                child:_isloading
                                    ?Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                                    :Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [

                                          TextFormField(
                                            decoration: textInputDecoration.copyWith(
                                              labelText: "Email",
                                              prefixIcon: Icon(
                                                Icons.email,
                                                color: Theme
                                                    .of(context)
                                                    .primaryColor,
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
                                          SizedBox(height: 15,),

                                          TextFormField(
                                            obscureText: true,
                                            decoration: textInputDecoration.copyWith(
                                                labelText: "Password",
                                                prefixIcon: Icon(
                                                  Icons.lock,
                                                  color: Theme
                                                      .of(context)
                                                      .primaryColor,
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

                                        ],
                                      ),
                                    )
                            ),
                          ],
                              ),
                        ),
                      ),
                    ),
                  ),


                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.5,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                            )
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: TextButton(onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ForgotPassword()));
                              }, child: Text(
                                  "forgot password?"
                              )),
                            ),
                            SizedBox(height: 10,),
                            Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    signIn(email,password);
                                  },
                                  child: Text("Sign in",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
    );

  }
  Future<bool> _onBackButtonPressed(BuildContext context) async{
    bool exitApp = await showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("SHU Transport"),
            content: const Text("Do you want to close the app?"),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop(false);
              }, child: const Text("No")),

              TextButton(onPressed: (){
                exit(0);
                // Navigator.of(context).pop(true);
              }, child: const Text("Yes")),

            ],
          );
        }
    );
    return exitApp ?? false;
  }


  Future signIn(String email, String password) async {
    String? status = "";
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      try{
        final User? user = (await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password)).user;


          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => Myapp()));
        showToast("You are Logged in");
      }on FirebaseAuthException catch(e){
        if(e.code == 'user-not-found'){
          showToast("No user found with this Email");
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('No user found with this Email')));
        }else if(e.code == 'wrong-password'){
          showToast("Email or Password did not match");
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Email or Password did not match')));
        }
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())));
      }
  }
}