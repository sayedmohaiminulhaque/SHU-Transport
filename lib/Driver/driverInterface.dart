import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_map_live/Drawer/developedBy.dart';
import 'package:google_map_live/Driver/staffDriver.dart';
import 'package:google_map_live/Driver/stuDriver.dart';
import 'package:google_map_live/Driver/teachDriver.dart';
import '../Authentication/authService.dart';
import '../Authentication/login.dart';
import '../Drawer/about.dart';


class DriverInterface extends StatefulWidget {
  const DriverInterface({Key? key}) : super(key: key);

  @override
  State<DriverInterface> createState() => _DriverInterfaceState();
}

class _DriverInterfaceState extends State<DriverInterface> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()=> _onBackButtonPressed(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "SHU Transport",
            style: TextStyle(
              fontSize: 25.0
            ),
          ),
        ),
        drawer: Drawer(                                                   //  Navigation bar
          child: ListView(

            children: [
              DrawerHeader(
                  padding: EdgeInsets.all(0),
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.blue.shade50),
                    accountName: Text("SHU Transport",style: TextStyle(color: Colors.black,fontSize:25),),
                    accountEmail: Text("transport@shu.edu.bd",style: TextStyle(color: Colors.red.shade500),),
                    currentAccountPicture: Image.asset("Image/bus.png"),
                  )
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DriverInterface()));
                },
              ),
              ListTile(
                leading: Icon(Icons.call),
                title: Text("Bus List"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DriverInterface()));
                },
              ),
              ListTile(
                leading: Icon(Icons.help)
                ,title: Text("Help"),
                onTap: (){},
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
                title: Text("About"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Log Out"),
                onTap: () async {
                  await authService.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                          (route) => false);
                },
              )
            ],
          ),
        ),

        body:  Padding(
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
                 onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherDriver()));},
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
                 onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>StuDriver()));},
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
                 onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>StaffDriver()));},
              ),


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
