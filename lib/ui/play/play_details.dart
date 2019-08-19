
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/dialog/bottom/bottomdialog.dart';
import 'package:flutter_app/model/song/SongInfoModel.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_app/ui/listener/Implements/onplaylistener.dart';



class PlayDetails extends StatelessWidget {



  final SongInfo songInfo;
  bool isHideClipWidget=false;//是否隐藏圆形
  PlayDetails({Key key, @required this.songInfo}) : super(key: key);

  ClipAAnimationWidget clipAAnimationWidget;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BottomDialog.instance.setJump(false);
    var imageUrl = songInfo.albumImg.replaceAll("{size}", "");
    print("songInfo.albumImg222:"+songInfo.albumImg);
    getClipWidget();
    return new GestureDetector(onTap: (){
      print("点击了页面");
      switchingState();
      if(clipAAnimationWidget!=null){
        clipAAnimationWidget.switchingView(isHideClipWidget);
      }
    },
    child: new Container(
      child: new Column(
        children: <Widget>[
          clipAAnimationWidget,
        ],
      ),color: Colors.white,
      padding: EdgeInsets.fromLTRB(20.0,150.0,20.0,0.0),
      alignment: Alignment.center,
    ) ,
    );
  }
  ClipAAnimationWidget getClipWidget(){
    if(clipAAnimationWidget==null){
      clipAAnimationWidget=new ClipAAnimationWidget(songInfo:songInfo);
    }
  }
  void  switchingState(){
      if(isHideClipWidget){
        isHideClipWidget=false;
      }else{
        isHideClipWidget=true;
      }
  }

}
class ClipAAnimationWidget extends StatefulWidget {

  final SongInfo songInfo;
  ClipAAnimation clipAAnimation;
  ClipAAnimationWidget({Key key, @required this.songInfo}) : super(key: key);

  void switchingView(bool switchView){
    if(clipAAnimation!=null){
      clipAAnimation.switchView(switchView);
    }
  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    if(clipAAnimation==null){
      clipAAnimation=new ClipAAnimation();
      clipAAnimation.setData(songInfo);
    }

    return clipAAnimation;
  }
}

class ClipAAnimation extends State<ClipAAnimationWidget>with SingleTickerProviderStateMixin{
  SongInfo songInfo;
  bool isSwitchView=false;
  void setData(SongInfo songInfo){
    this.songInfo=songInfo;
  }
  initState() {
    super.initState();
    _getController();
    initPlayListener();
  }
//创建一个动画controller
  AnimationController controller;
  AnimationController _getController(){
    controller =
        AnimationController(duration: const Duration(milliseconds: 20000),vsync: this
        );
    //动画开始、结束、向前移动或向后移动时会调用StatusListener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        print("status is completed");
        //重置起点
        controller.reset();
        //开启
        controller.forward();
      } else if (status == AnimationStatus.dismissed) {
        //动画从 controller.reverse() 反向执行 结束时会回调此方法
        print("status is dismissed");
      } else if (status == AnimationStatus.forward) {
        print("status is forward");
        //执行 controller.forward() 会回调此状态
      } else if (status == AnimationStatus.reverse) {
        //执行 controller.reverse() 会回调此状态
        print("status is reverse");
      }
      controller.forward();
    });
    controller.forward();
    return controller;
  }
  void initPlayListener(){
    OnMusicPlayListener onMusicPlayListener=new OnMusicPlayListener();
    onMusicPlayListener.setAnimationController(controller);
    BottomDialog.instance.setOnPlayListener(onMusicPlayListener);
  }
  void switchView(bool switchView){
    setState((){
      isSwitchView=switchView;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var imageUrl = songInfo.albumImg.replaceAll("{size}", "");
    print("songInfo.albumImg333:"+songInfo.albumImg);
//    _getController();
    return new Container(
      child: new Column(
        children: <Widget>[
          getContentWidget(imageUrl)
        ],
      ),color: Colors.white,
      padding: EdgeInsets.fromLTRB(20.0,0.0,20.0,0.0),
      alignment: Alignment.center,
    );
  }


  Widget getContentWidget(String imageUrl){
    Widget contentWidget=null;
    if(!isSwitchView){
      contentWidget=new RotationTransition(turns: controller
        ,alignment: Alignment.center,
        child: Container(
            child: new Column(children: <Widget>[
              new ClipRRect(borderRadius: BorderRadius.circular(250.0),
                child: new Image.network(imageUrl,),
              )
            ],),color: Colors.white
        ),
      );
    }else{
      contentWidget=new Text("歌词正在加载中");
    }
    return contentWidget;
  }
}

