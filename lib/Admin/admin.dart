import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_map_live/Admin/addBus.dart';
import 'package:google_map_live/Admin/busLocation.dart';
import 'package:google_map_live/Admin/users.dart';
import 'package:google_map_live/Authentication/registation.dart';
import 'package:google_map_live/Driver/driverList.dart';
import 'package:google_map_live/Driver/stuDriver.dart';
import 'package:google_map_live/Notification/notificationAPI.dart';
import 'package:google_map_live/main.dart';
import 'package:google_map_live/Profile/profile.dart';

import '../Authentication/authService.dart';
import '../Authentication/login.dart';
class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>_onBackButtonPressed(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Admin Panel",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              container("Bus Location",0),
              container("Add New User",1),
              container("Driver List",2),
              container("Profiles",3),
              container("Add Bus",4),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,100.0,0,0),
                child: InkWell(
                  onTap: () async {
                    await authService.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                            (route) => false);
                  },
                  child: Text("Log out",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
              )
            ],
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

Widget container(String? name,int cls){
  List pages = [BusLocation(),StudentRegi(),DriverList(),Users(),AddBus()];
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Builder(
        builder: (context) {
          return InkWell(
            onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => pages[cls]));},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.blue.shade50,],
                  tileMode: TileMode.clamp,
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(name.toString(),
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Raleway",
                      ),
                    ),
                   // Text(subname.toString()),
                  ],
                ),
              ),
            ),
          );
        }
    ),
  );
}