import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF42a5f5), width: 2),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF42a5f5), width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF42a5f5), width: 2),
  ),
);

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}
//
// Widget busContainer(String tname,String lname,int who){
//   return Builder(
//       builder: (context) {
//         return InkWell(
//           child: Container(
//             child: Column(
//               children: [
//                 Container(
//                   child: Image.asset("Image/bus1.png"),
//                 ),
//                 Text(tname,
//                   style: TextStyle(
//                     fontSize: 25.0,
//                   ),
//                 )
//               ],
//             ),
//
//             decoration: BoxDecoration(
//                 color: Colors.blue.shade50,
//                 border: Border.all(color: Colors.blue,width: 2)
//             ),
//           ),
//           onTap: (){
//             if(who == 0) {
//              // Navigator.push(context, MaterialPageRoute(builder: (context) =>
//                  // BusRouteMap(tname: tname, lname: lname,whichBus: 'student bus',)));
//             }
//             else{
//               Navigator.push(context, MaterialPageRoute(builder: (context) =>
//                   MyMap(lname)));
//             }
//             },
//         );
//       }
//   );
// }

 void showToast(String toast){
  Fluttertoast.showToast(
    msg: toast,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black.withOpacity(0.7),
    textColor: Colors.white,
    fontSize: 16.0
  );
}

