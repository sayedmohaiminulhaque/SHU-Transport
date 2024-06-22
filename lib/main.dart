import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_map_live/Authentication/login.dart';
import 'package:google_map_live/home.dart';
import 'package:google_map_live/mymap.dart';
import 'package:google_map_live/Profile/profile.dart';
import 'package:google_map_live/splashScreen.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'Authentication/authService.dart';
import 'Authentication/registation.dart';
import 'Driver/driverInterface.dart';
import 'Admin/admin.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  runApp(MaterialApp(
      home: const SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);
  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {

  String? status = "";


  @override
  void initState() {
    checkUser();
    super.initState();
  }

  Future checkUser() async {
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
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){

        if(snapshot.connectionState==ConnectionState.active){
          if(snapshot.hasData ){
            if(status == "Admin"){
              return const AdminPanel();
            }
            else if(status=="Driver"){
              return const DriverInterface();
            }else{
              return const HomeActivity();
            }
          } else if (snapshot.hasError){
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child:  CircularProgressIndicator(
            ),
          );
        }
        return const LoginPage();
        }
    );
  }
}










class BusRouteMap extends StatefulWidget {
  final String? busName,busSerialNo;
  final String whichBus;
  const BusRouteMap({Key? key,this.busName,this.busSerialNo,required this.whichBus}) : super(key: key);

  @override
  _BusRouteMapState createState() => _BusRouteMapState();
}

class _BusRouteMapState extends State<BusRouteMap> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.busName.toString()),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  _getLocation();
                },
                child: Text('Add my location')),
            ElevatedButton(
                onPressed: () {
                  _listenLocation();
                },
                child: Text('Enable live location')),
            ElevatedButton(
                onPressed: () {
                  _stopListening();
                },
                child: Text('Stop live location')),
            Expanded(
                child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection(widget.whichBus).snapshots(),
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
                        // trailing: IconButton(
                        //   icon: Icon(Icons.directions),
                        //   onPressed: () {
                        //     Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) =>
                        //             MyMap(snapshot.data!.docs[index].id)));
                        //     print(snapshot.data!.docs[index].id);
                        //   },
                        // ),
                      );
                    });
              },
            )),
          ],
        ),
      ),
    );
  }

  // Location added to the firebase


  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection(widget.whichBus).doc(widget.busSerialNo).set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'name': widget.busName
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection(widget.whichBus).doc(widget.busSerialNo).set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': widget.busName
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
