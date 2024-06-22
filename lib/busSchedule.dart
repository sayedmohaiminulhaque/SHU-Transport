import 'package:flutter/material.dart';
class BusSchedule extends StatefulWidget {
  const BusSchedule({Key? key}) : super(key: key);

  @override
  State<BusSchedule> createState() => _BusScheduleState();
}

class _BusScheduleState extends State<BusSchedule> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bus Schedule'
        ),
      ),
      body: Center(child: Text('Under Construction',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0
          ),
      ),
      )
    );
  }
}
