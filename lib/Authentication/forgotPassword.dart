import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
 final emailController = TextEditingController();
 final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: textInputDecoration.copyWith(
                labelText: "Enter your email",
                prefixIcon: Icon(
                  Icons.email,
                  color: Theme
                      .of(context)
                      .primaryColor,
                )),
          ),
          SizedBox(height: 40,),
          ElevatedButton(onPressed: (){
              auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
                showToast("email is sent");
              }).onError((error, stackTrace) {
                    showToast(error.toString());
              });
          }, child: Text("SEND"))
        ],
      ),
    );
  }
}
