import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:world_clock/services/world_time.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Map data = {};

  @override
  void initState() {
    setUpWorldTime();
    super.initState();
  }

  void setUpWorldTime() async {
    WorldTime instance = WorldTime(location: 'Dublin',flag: 'dublin.png',url:'Europe/Dublin');
    print(instance.isDayTime);

    //If you don't write await then the print line will execute before we getData.
    //That's why we need to add await in front of getData.
    await instance.getData();
    //Replace old with new widget
    print("*** ${instance.isDayTime}");

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      "time": instance.time,
      "location": instance.location,
      "flag": instance.flag,
      "isDayTime":instance.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.blue[900],
          size: 80.0,
        ),
      )
    );
  }
}
