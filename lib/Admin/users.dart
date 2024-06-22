import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Authentication/authService.dart';
class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  AuthService authService = AuthService();
  deletedata(id)async{
    await FirebaseFirestore.instance.collection('users').doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                stream:
                FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data!.docs[index]['fullName'].toString()),
                          subtitle: Text(snapshot.data!.docs[index]['email']),
                          trailing: IconButton(
                            onPressed: (){
                              deletedata(snapshot.data!.docs[index].id);
                              setState(() {
                              });
                            },
                            icon: Icon(Icons.delete,color: Colors.red,),
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
