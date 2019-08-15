import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/test.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
  ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('第一个页面'),
        backgroundColor: Colors.red,
      ),
      body: new Center(
        child: new RaisedButton(
          child: new Text('跳转'),
          onPressed: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) => new test()));
          },
        ),
      ),
    );
  }
}
 class SplashScreen extends StatefulWidget {
     @override
     _SplashScreenState createState() => new _SplashScreenState();
   }
class _SplashScreenState extends State<SplashScreen> {
     startTime() async {
       //设置启动图生效时间
       var _duration = new Duration(milliseconds:1 );
       return new Timer(_duration, startJump);
     }

     void navigationPage() {
       Navigator.push(context, new MaterialPageRoute(builder: (context) => new test()));
     }
     startJump() async{
       var _duration = new Duration(seconds:2 );
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
           child: new Image.asset('images/bg_starting.png',fit:BoxFit.fill, width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height,),
         ),
       );
     }
   }