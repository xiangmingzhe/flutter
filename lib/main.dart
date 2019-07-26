import 'package:flutter/material.dart';
import 'package:flutter_app/test.dart';

void main() {
  runApp(new MaterialApp(
    title: '页面跳转',
    home: new FirstScreen(),
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
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new SecondScreen()),
            );
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('第二个页面'),
        backgroundColor: Colors.brown,
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: () {
//            Navigator.pop(context);
            Navigator.push(context, new MaterialPageRoute(builder: (context) => new test()));
          },
          child: new Text('返回'),
        ),
      ),
    );
  }
}