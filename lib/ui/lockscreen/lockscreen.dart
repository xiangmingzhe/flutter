import 'package:flutter/material.dart';

class LockScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LockScreenState();
  }
}

class LockScreenState extends State<LockScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _widget();
  }

  Widget _widget() {
    return new Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1, //pageview 所占布局比
            child: new Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/timg.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1, //listview 所占布局比
              child: new Text("滑动解锁"))
        ],
      ),
    );
  }
}
