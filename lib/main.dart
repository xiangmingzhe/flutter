import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/ui/home/home.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    //设置启动图生效时间
    var _duration = new Duration(milliseconds: 1);
    return new Timer(_duration, startJump);
  }
  void navigationPage() {
    Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(
      builder: (BuildContext context) {
        return new test();
      },
    ), (route) => route == null);
  }

  startJump() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset(
          'images/bg_starting.png',
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
