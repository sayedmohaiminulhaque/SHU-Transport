import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_map_live/Driver/stuDriver.dart';

import '../home.dart';
import '../main.dart';
import '../mymap.dart';
import '../Profile/profile.dart';
import '../widgets.dart';
class TeacherDriver extends StatefulWidget {
  final int? val;
  const TeacherDriver({Key? key,this.val}) : super(key: key);

  @override
  State<TeacherDriver> createState() => _TeacherDriverState();
}

class _TeacherDriverState extends State<TeacherDriver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher Bus"),
      ),
      body:  StreamBuilder(
        stream:
        FirebaseFirestore.instance.collection("teacherBus").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 11,
                mainAxisSpacing: 11),
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  return  InkWell(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: Image.asset("Image/bus1.png"),
                          ),
                          Text(snapshot.data!.docs[index]['name'].toString(),
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
                      if(widget.val ==1){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            MyMap(snapshot.data!.docs[index].id.toString(),"teacherBus")));
                      }
                      else{
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            BusRouteMap(busName: snapshot.data!.docs[index]['name'].toString(), busSerialNo: snapshot.data!.docs[index].id.toString(),whichBus: 'teacherBus',)));
                      }
                    },
                  );

                }),
          );
        },
      ),
    );
  }
}
