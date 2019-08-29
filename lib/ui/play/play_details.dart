import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/dialog/bottom/bottomdialog.dart';
import 'package:flutter_app/model/song/SongInfoModel.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_app/ui/listener/Implements/onplaylistener.dart';
import 'package:flutter_app/widget/wave_widget.dart';

class PlayDetails extends StatelessWidget {
  final SongInfo songInfo;
  final String lrc;
  bool isHideClipWidget = false; //是否隐藏圆形
  PlayDetails({Key key, @required this.songInfo, @required this.lrc})
      : super(key: key);

  ClipAAnimationWidget clipAAnimationWidget;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BottomDialog.instance.setJump(false);
    var imageUrl = songInfo.albumImg.replaceAll("{size}", "");
    print("songInfo.albumImg222:" + songInfo.albumImg);
    getClipWidget();
    return new GestureDetector(
      onTap: () {
        print("点击了页面");
        switchingState();
        if (clipAAnimationWidget != null) {
          clipAAnimationWidget.switchingView(isHideClipWidget);
        }
      },
      child: new Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/timg.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: new Column(
          children: <Widget>[
            clipAAnimationWidget,
          ],
        ),
        padding: EdgeInsets.fromLTRB(20.0, 150.0, 20.0, 0.0),
        alignment: Alignment.center,
      ),
    );
  }

  ClipAAnimationWidget getClipWidget() {
    if (clipAAnimationWidget == null) {
      clipAAnimationWidget =
          new ClipAAnimationWidget(songInfo: songInfo, lrc: lrc);
    }
  }

  void switchingState() {
    if (isHideClipWidget) {
      isHideClipWidget = false;
    } else {
      isHideClipWidget = true;
    }
  }
}

class ClipAAnimationWidget extends StatefulWidget {
  final SongInfo songInfo;
  final String lrc;
  ClipAAnimation clipAAnimation;

  ClipAAnimationWidget({Key key, @required this.songInfo, @required this.lrc})
      : super(key: key);

  void switchingView(bool switchView) {
    if (clipAAnimation != null) {
      clipAAnimation.switchView(switchView);
    }
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    if (clipAAnimation == null) {
      clipAAnimation = new ClipAAnimation();
      clipAAnimation.setData(songInfo, lrc);
    }

    return clipAAnimation;
  }
}

class ClipAAnimation extends State<ClipAAnimationWidget>
    with SingleTickerProviderStateMixin {
  SongInfo songInfo;
  bool isSwitchView = false;
  String lrc;
  Widget lrcWidget;
  Widget rotationTransition;

  void setData(SongInfo songInfo, String lrc) {
    this.songInfo = songInfo;
    this.lrc = lrc;
  }

  initState() {
    super.initState();
    _getController();
    initPlayListener();
  }

//创建一个动画controller
  AnimationController controller;

  AnimationController _getController() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 20000), vsync: this);
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

  void initPlayListener() {
    OnMusicPlayListener onMusicPlayListener = new OnMusicPlayListener();
    onMusicPlayListener.setAnimationController(controller);
    BottomDialog.instance.setOnPlayListener(onMusicPlayListener);
  }

  void switchView(bool switchView) {
    setState(() {
      isSwitchView = switchView;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (controller != null) controller.stop();
    BottomDialog.instance.setJump(true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var imageUrl = songInfo.albumImg.replaceAll("{size}", "");
    return new Container(

      child: new Column(
        children: <Widget>[getContentWidget(imageUrl)],
      ),
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      alignment: Alignment.center,
    );
  }

  Widget getContentWidget(String imageUrl) {
    Widget contentWidget = null;
    if (!isSwitchView) {
      if (rotationTransition == null) {
        rotationTransition = new RotationTransition(
          turns: controller,
          alignment: Alignment.center,
          child: Container(
              child: new Column(
                children: <Widget>[
                  new Stack(
                    children: <Widget>[
                      new ClipOval(
                        child: new Image.network(
                          imageUrl,
                          fit: BoxFit.fitWidth,
                          width: 280,
                          height: 280.0,
                        ),
                      ),
                      new CustomPaint(
                        painter: WaveCircle()),

                    ],
                  )
                ],
              ),
             ),
        );
      }
      contentWidget = rotationTransition;
    } else {
      if (lrcWidget == null) {
        lrcWidget = new Text(
          "歌词加载中...",
          style: TextStyle(color: Colors.red, decoration: TextDecoration.none),
        );
//        lrcWidget=new ListView.builder(itemCount: 10, shrinkWrap: true,itemBuilder: (context,index){
//          return new ListTile(title: new Text("歌词加载中",style: TextStyle(fontSize: 20,color: Colors.yellow),),);
//        });
      }
      contentWidget = lrcWidget;
    }
    return contentWidget;
  }
}
