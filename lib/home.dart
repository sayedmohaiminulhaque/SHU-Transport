import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_map_live/Drawer/about.dart';
import 'package:google_map_live/Drawer/developedBy.dart';
import 'package:google_map_live/Driver/driverList.dart';
import 'package:google_map_live/Driver/staffDriver.dart';
import 'package:google_map_live/Driver/stuDriver.dart';
import 'package:google_map_live/Driver/teachDriver.dart';
import 'package:google_map_live/busList.dart';
import 'package:google_map_live/busSchedule.dart';
import 'package:google_map_live/Profile/profile.dart';
import 'package:google_map_live/privacyPolicy.dart';
import 'package:google_map_live/widgets.dart';

import 'Authentication/authService.dart';
import 'Authentication/login.dart';

class HomeActivity extends StatefulWidget {
  const HomeActivity({Key? key}) : super(key: key);

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}
class _HomeActivityState extends State<HomeActivity>{

  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()=> _onBackButtonPressed(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("SHU Transport"),
        ),
        drawer: Drawer(                                                   //  Navigation bar
          child: ListView(

            children: [
              DrawerHeader(
                  child: UserAccountsDrawerHeader(
                    currentAccountPictureSize: Size.square(50.0),
                    decoration: BoxDecoration(color: Colors.blue.shade50),
                    accountName: Text("SHU Transport",style: TextStyle(color: Colors.black,fontSize:22),),
                    accountEmail: Text("transport@shu.edu.bd",style: TextStyle(color: Colors.red.shade500),),
                    currentAccountPicture: Image.asset("Image/bus.png"),
                  )
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeActivity()));
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                },
              ),

              ListTile(
                leading: Icon(Icons.bus_alert_sharp),
                title: Text("Bus List"),
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>BusList()));
                 },
              ),

              ListTile(
                leading: Icon(Icons.call),
                title: Text("Drivers Number"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DriverList()));
                },
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip_outlined)
                ,title: Text("Privacy"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicy()));
                },
              ),
              ListTile(
                leading: Icon(Icons.developer_board),
                title: Text("Developed By"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DevelopedBy()));
                },
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text("About "),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Log Out"),
                onTap: () async {
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
              )
            ],
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: GridView.count(

                crossAxisCount: 2,
                crossAxisSpacing: 11,
              mainAxisSpacing: 11,
              children: [
                InkWell(
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset("Image/bus1.png"),
                          ),
                          Text("Bus List",
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BusList()));
                  },
                ),
                InkWell(
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset("Image/bus1.png"),
                          ),
                          Text("Bus Schedule",
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BusSchedule()));
                  },
                ),
                InkWell(
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: CircleAvatar(
                              radius: 55.0,
                              backgroundImage: AssetImage("Image/Driver.png"),
                              backgroundColor: Colors.blue.shade50,
                            )
                          ),
                          Text("Driver List",
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DriverList()));
                  },
                ),

                InkWell(
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: CircleAvatar(
                              radius: 55.0,
                              backgroundImage: AssetImage("Image/person.png"),
                              backgroundColor: Colors.blue.shade50,
                            ),
                          ),
                          Text("Profile",
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                  },
                ),


              ],
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
}