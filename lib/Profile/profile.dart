import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_map_live/Profile/addData.dart';
import 'package:google_map_live/Profile/utils.dart';
import 'package:image_picker/image_picker.dart';
import '../Authentication/authService.dart';
import '../Authentication/login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthService authService = AuthService();
  String? username = "";
  String? status = "";
  String? email = "";
  String? mobile = "";
  Uint8List? _image;

  void saveProfile()async{
    String resp = await StoreData().saveData(file: _image!);
  }

  void selectImage()async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }


  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future getUser() async {

    print(FirebaseAuth.instance.currentUser!.uid);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          username = snapshot.data()!["fullName"];
          status = snapshot.data()!["status"];
          email = snapshot.data()!["email"];
          mobile = snapshot.data()!["mobile"];
        });
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.0,
                ),
                // Stack(
                //   children: [_image!=null?
                //       CircleAvatar(
                //         radius: 64,
                //         backgroundImage: MemoryImage(_image!),
                //       ):
                    CircleAvatar(
                      radius: 64.0,
                      backgroundImage: AssetImage("Image/person.png"),
                    ),
                  //   Positioned(child: IconButton(
                  //     onPressed: selectImage,
                  //     icon: Icon(Icons.add_a_photo),
                  //   ),
                  //     bottom: -10,
                  //     left: 80,
                  //   )
                  // ],
                // ),
                SizedBox(height: 10.0,),
                Text(
                  username!,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,color: Colors.black),
                ),
                SizedBox(height: 15.0,),
                Text(
                  "Status : "+status!,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Mobile : "+mobile!,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Email : "+email!,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 20.0,),
                // ElevatedButton(onPressed: saveProfile, child: Text("Save Profile Picture")),
                SizedBox(
                  height: 60.0,
                ),
                ElevatedButton(
                    onPressed: () async {
                      bool exitApp = await showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: const Text("Log Out"),
                              content: const Text("Do you want to log out?"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop(false);
                                }, child: const Text("No")),

                                TextButton(onPressed: (){
                                   authService.signOut();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => const LoginPage()),
                                          (route) => false);
                                }, child: const Text("Yes")),

                              ],
                            );
                          }
                      );
                    },
                    child: Text(
                      "Log Out",
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
