import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../mymap.dart';
class BusLocation extends StatefulWidget {
  const BusLocation({Key? key}) : super(key: key);

  @override
  State<BusLocation> createState() => _BusLocationState();
}

class _BusLocationState extends State<BusLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bus Location"),
      ),
      body: Column(
        children: [
          Text("Student Bus:"),
          busLocation("studentBus"),
          Text("Staff Bus:"),
          busLocation("staffBus"),
          Text("Teacher Bus:"),
          busLocation("teacherBus"),
          // StreamBuilder(
          //   stream:
          //   FirebaseFirestore.instance.collection('busLocation').snapshots(),
          //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //     if (!snapshot.hasData) {
          //       return Center(child: CircularProgressIndicator());
          //     }
          //     return ListView.builder(
          //         itemCount: snapshot.data?.docs.length,
          //         itemBuilder: (context, index) {
          //           return ListTile(
          //             title:
          //             Text(snapshot.data!.docs[index]['name'].toString()),
          //             subtitle: Row(
          //               children: [
          //                 Text(snapshot.data!.docs[index]['latitude']
          //                     .toString()),
          //                 SizedBox(
          //                   width: 20,
          //                 ),
          //                 Text(snapshot.data!.docs[index]['longitude']
          //                     .toString()),
          //               ],
          //             ),
          //             trailing: IconButton(
          //               icon: Icon(Icons.directions),
          //               onPressed: () {
          //                 Navigator.of(context).push(MaterialPageRoute(
          //                     builder: (context) =>
          //                         MyMap(snapshot.data!.docs[index].id,"studentBus")));
          //                 print(snapshot.data!.docs[index].id);
          //               },
          //             ),
          //           );
          //         });
          //   },
          // ),
        ],
      ),
    );
  }
}

Widget busLocation(String whichBus){
  return Expanded(
    child:StreamBuilder(
    stream:
    FirebaseFirestore.instance.collection(whichBus).snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) {
        return Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            return ListTile(
              title:
              Text(snapshot.data!.docs[index]['name'].toString()),
              subtitle: Row(
                children: [
                  Text(snapshot.data!.docs[index]['latitude']
                      .toString()),
                  SizedBox(
                    width: 20,
                  ),
                  Text(snapshot.data!.docs[index]['longitude']
                      .toString()),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.directions),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          MyMap(snapshot.data!.docs[index].id,whichBus)));
                },
              ),
            );
          });
    },
  ));
}