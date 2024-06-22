import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_map_live/widgets.dart';

import 'Authentication/authService.dart';
import 'Driver/staffDriver.dart';
import 'Driver/stuDriver.dart';
import 'Driver/teachDriver.dart';
class BusList extends StatefulWidget {
  const BusList({Key? key}) : super(key: key);

  @override
  State<BusList> createState() => _BusListState();
}

class _BusListState extends State<BusList> {


  AuthService authService = AuthService();
  String status = "";


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
          status = snapshot.data()!["status"];

        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bus List"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 11,
          mainAxisSpacing: 11,
          children: [
            InkWell(
              child: Container(
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset("Image/bus1.png"),
                      ),
                      Text("Teacher Bus",
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      )
                    ],
                  ),

                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border.all(color: Colors.blue,width: 2),
                  )
              ),

              onTap: (){
                if(status=='Teacher'){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherDriver(val: 1)));
                }
                else{
                  showToast("You don't have access");
                }
              },
            ),

            InkWell(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Image.asset("Image/bus1.png"),
                    ),
                    Text("Student Bus",
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    )
                  ],
                ),

                decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border.all(color: Colors.blue,width: 2)
                ),
              ),
              onTap: (){
                if(status=='Student'){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StuDriver(val: 1,)));
                }
                else{
                  showToast("You don't have access");
                }
              },
            ),
            InkWell(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Image.asset("Image/bus1.png"),
                    ),
                    Text("Staff Bus",
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border.all(color: Colors.blue,width: 2)
                ),
              ),
              onTap: (){
                if(status=='Staff'){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StaffDriver(val: 1,)));
                }
                else{
                  showToast("You don't have access");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
