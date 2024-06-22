import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Authentication/authService.dart';
class DriverList extends StatefulWidget {
  const DriverList({Key? key}) : super(key: key);

  @override
  State<DriverList> createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  AuthService authService = AuthService();
  // int val = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Driver's List"),
        ),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                  stream:
                  FirebaseFirestore.instance.collection("driverList").snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                           return Padding(
                             padding: const EdgeInsets.all(8.0),
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

                               child: ListTile(
                                 title: Text(snapshot.data!.docs[index]['name'].toString()),
                                 subtitle: Text(snapshot.data!.docs[index]['mobile'].toString()),
                                 trailing: ElevatedButton(
                                   onPressed: ()async{
                                     Uri url = Uri(scheme: 'tel',path:snapshot.data!.docs[index]['mobile'].toString() );
                                     if(await canLaunchUrl(url)){
                                       await launchUrl(url,
                                       mode: LaunchMode.platformDefault,
                                       );
                                     }else{
                                       throw "Can't launch call";
                                     }
                                     //await FlutterPhoneDirectCaller.callNumber(snapshot.data!.docs[index]['mobile'].toString());
                                   },
                                   child: Icon(Icons.call,color: Colors.green,),
                                 ),
                               ),
                             ),
                           );
                        });
                  },
                )),
          ],
        )
    );
  }

}
