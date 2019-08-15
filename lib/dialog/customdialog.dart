import 'dart:async';
import 'package:flutter/material.dart';

class LoadingDialog extends StatefulWidget {
  String loadTitle;
  bool outsideDismiss;
  Function dismissCallback;
  Future<dynamic> requestCallBack;
  bool dissDialog=false;
  _BuilderLoadingDialog dialog;
  LoadingDialog(
      {Key key,
      this.loadTitle = "loading...",
      this.outsideDismiss = true,
      this.dismissCallback,
      this.dissDialog,
      this.requestCallBack})
      : super(key: key);

  void dismissDialog(bool dismissDialog){
    dissDialog=dismissDialog;
  }
  void initDialog(){
    dialog=new _BuilderLoadingDialog();
  }
  @override
  State<LoadingDialog> createState() => dialog;

}
class _BuilderLoadingDialog extends State<LoadingDialog>{
  _dismissDialog() {
    if (widget.dismissCallback != null) {
      widget.dismissCallback();
    }
    print("点击了消失");
    Navigator.of(context).pop();
  }
  BuildContext  mBuildContext;
  @override
  void initState() {
    super.initState();
    if (widget.requestCallBack != null) {
      widget.requestCallBack.then((_) {
        Navigator.pop(context);
      });
    }
  }
  void dimissDialog(){
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    mBuildContext=context;
    return new GestureDetector(
      onTap: widget.outsideDismiss ? _dismissDialog : null,
      child: Material(
        type: MaterialType.transparency,
        child: new Center(
          child: new SizedBox(
            width: 120.0,
            height: 120.0,
            child: new Container(
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: new Text(
                      widget.loadTitle,
                      style: new TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

