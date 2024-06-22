import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class MyMap extends StatefulWidget {
  final String user_id;
  final String whichBus;
  MyMap(this.user_id,this.whichBus);
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {

  //     BitmapDescriptor? customIcon;
  //
  //
  // createMarker(context)async{
  //   if(customIcon==null){
  //     ImageConfiguration configuration = createLocalImageConfiguration(context,size: Size(2, 2));
  //     BitmapDescriptor.fromAssetImage(configuration, 'Image/bus2.png')
  //     .then((icon){
  //       setState(() {
  //         customIcon = icon;
  //       });
  //     });
  //   }
  // }

  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;
  @override
  Widget build(BuildContext context) {
    // createMarker(context);
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection(widget.whichBus).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (_added) {
          mymap(snapshot);
        }
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return GoogleMap(
          mapType: MapType.normal,
          markers: {
            Marker(
                position: LatLng(
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.user_id)['latitude'],
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.user_id)['longitude'],
                ),
                markerId: MarkerId('id'),
                // icon: customIcon!
               icon:
                BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueMagenta)
            ),
          },
          initialCameraPosition: CameraPosition(
              target: LatLng(
                snapshot.data!.docs.singleWhere(
                    (element) => element.id == widget.user_id)['latitude'],
                snapshot.data!.docs.singleWhere(
                    (element) => element.id == widget.user_id)['longitude'],
              ),
              zoom: 24.47),
          onMapCreated: (GoogleMapController controller) async {
            setState(() {
              _controller = controller;
              _added = true;
            });
          },
        );
      },
    ));
  }

  Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await _controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)['latitude'],
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)['longitude'],
            ),
            zoom: 17.00)));
  }
}
