import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Authentication/authService.dart';
import '../widgets.dart';
class AddBus extends StatefulWidget {
  const AddBus({Key? key}) : super(key: key);

  @override
  State<AddBus> createState() => _AddBusState();
}

class _AddBusState extends State<AddBus> {
  String dropValue = "";
  String busSerialNo = "";
  String busName = "";
  AuthService authService = AuthService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  List listItem = [ "teacherBus","studentBus","staffBus" ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Bus"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DropdownButtonFormField(                                              // Dropdown Menu
            value: dropValue.isNotEmpty?dropValue:null,
            onChanged: (newValue){
              setState(() {
                dropValue = newValue as String ;
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
              labelText: "Bus For",
              prefixIcon: Icon(
                Icons.bus_alert_rounded,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          TextFormField(                                                            // Bus Serial NO
            decoration: textInputDecoration.copyWith(
                labelText: "Bus Serial No",
                prefixIcon: Icon(
                  Icons.bus_alert_rounded,
                  color: Theme.of(context).primaryColor,
                )),
            onChanged: (val) {
              setState(() {
                busSerialNo = val;
              });
            },
            validator: (val) {
              if (val!.isNotEmpty) {
                return null;
              } else {
                return "Bus Serial Number cannot be empty";
              }
            },
          ),
          SizedBox(height: 20.0,),
          TextFormField(                                                            // Bus Name
            decoration: textInputDecoration.copyWith(
                labelText: "Bus Name",
                prefixIcon: Icon(
                  Icons.bus_alert_outlined,
                  color: Theme.of(context).primaryColor,
                )),
            onChanged: (val) {
              setState(() {
                busName = val;
              });
            },
            validator: (val) {
              if (val!.isNotEmpty) {
                return null;
              } else {
                return "Bus Name cannot be empty";
              }
            },
          ),
          SizedBox(height: 40.0,),
          ElevatedButton(onPressed: (){
            addBus(dropValue,busSerialNo,busName);
          },
              child: Text("Add Bus",
              style: TextStyle(
                fontSize: 20.0,
              ),)
          )

        ],
      ),
    );
  }

  void addBus(String dropValue, String busSerialNo, String busName) async{
    try{
      await FirebaseFirestore.instance.collection(dropValue).doc(busSerialNo).set({
        'name': busName,
      });
      showToast("Successfully Added");
    }catch(e){
      showToast(e.toString());
    }

  }
}
