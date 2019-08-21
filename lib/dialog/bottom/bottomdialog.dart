 import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/model/song/SongInfoModel.dart';
import 'package:flutter_app/ui/home/home.dart';
import 'package:flutter_app/ui/listener/Interface/onPlayListener.dart';
import 'package:flutter_app/ui/page/newMusicListPage.dart';
import 'package:flutter_app/ui/play/play_details.dart';


class BottomDialog{

  // 工厂模式
  factory BottomDialog() =>_getInstance();
  static BottomDialog get instance => _getInstance();
  static BottomDialog _instance;
  BottomDialog._internal() {
    // 初始化
  }
  static BottomDialog _getInstance() {
    if (_instance == null) {
      _instance = new BottomDialog._internal();
    }
    return _instance;
  }



  OverlayEntry bottomOverlayEntry;
  String imageUrl;
  String songName;
  String lrc;
  String singerName;
  var _count;
  var iconUrl;
  bool isRefreshIcon=false;
  bool isJump=true;//是否支持跳转
  setState(){

    if(isRefreshIcon){ //刷新icon
      if (_count == 0) {
        //播放
        iconUrl = "images/s_pause.png";
        if(onPlayListener!=null){
          onPlayListener.onPlay();
        }
      } else if (_count == 2) {
        //暂停
        iconUrl = "images/s_play.png";
        if(onPlayListener!=null){
          onPlayListener.onPause();
        }
      }
      print("setState*******************");
      print(isRefreshIcon);
      print(iconUrl);
    }else{ //刷新内容

    }


  }
  void updateIocn(int playStatus){
    _count=playStatus;
    isRefreshIcon=true;
    setState();
  }
  void setJump(bool isJump){
    this.isJump=isJump;
    setState();
  }
  void updateDialogData(String imageUrl,String songName,String singerName,String lrc){
      this.imageUrl=imageUrl;
      this.songName=songName;
      this.singerName=singerName;
      this.lrc=lrc;
      isRefreshIcon=false;
      setState();
  }



   /**
    * 展示微信下拉的弹窗
    */

  void showBottomDialog(BuildContext buildContext,
       var _platform,var _musicPlatform) {
    //                     bottomOverlayEntry.remove();
    print("showBottomDialog");
    if(bottomOverlayEntry!=null){
      bottomOverlayEntry.remove();
    }
     if(null==iconUrl){
       iconUrl = "images/s_pause.png";
     }
     bottomOverlayEntry = new OverlayEntry(builder: (context) {
       return new Positioned(
           bottom: 0,
           width: 700,
           height: 90,
           child: new SafeArea(
               child: new Material(
                 child: GestureDetector(
                   onTap: () {
                     if(isJump){
                       _platform
                           .invokeMethod('showall', {'msg': "点击了悬浮栏"}); //调用相应方法，并传入相关参数。
                       Navigator.push(
                         context,
                         new MaterialPageRoute(
                           builder: (context) => new PlayDetails(songInfo: songInfo,lrc:lrc),
                         ),
                       );

                     }else{

                     }
                   },
                   child: new Container(
                     color: Colors.amberAccent,
                     child: new Row(
                       children: <Widget>[
                         FadeInImage.assetNetwork(
                           image: imageUrl,
                           placeholder: "images/s_pause.png",
                         ),
                         new Container(
                             child: new Column(
                               children: <Widget>[
                                 new Container(
                                   child: new Column(
                                     children: <Widget>[Text(songName.trim())],
                                   ),
                                   padding: const EdgeInsets.fromLTRB(8.0, 8.0, 2.0, 2.0),
                                 ),
                                 new Container(
                                   child: new Column(
                                     children: <Widget>[Text(singerName.trim())],
                                   ),
                                   padding: const EdgeInsets.fromLTRB(8.0, 8.0, 2.0, 2.0),
                                 )
//                    new Positioned(top: 20,width: 60,height: 60,child: new Text(songName)),new Positioned(bottom: 20,width: 60,height: 60,child: new Text(singerName))
                               ],
                             )),
                         new Container(
                           margin:EdgeInsets.only(left: 80),
                           child: new Row(
                             children: <Widget>[
                               InkWell(
                                 child: new Image(
                                   image: new AssetImage(iconUrl,),height: 40,width: 40,),
                                 onTap: () {
                                   _musicPlatform.invokeMethod(
                                       'onPause', {'url': null}); //调用相应方法，并传入相关参数。
                                 },
                               )
                             ],
                           ),
//                    padding: const EdgeInsets.fromLTRB(150.0, 2.0, 2.0, 2.0),
                           alignment:Alignment.centerRight ,
                         )
                       ],
                     ),
                   ),
                 ),
               )));
     });
     Overlay.of(buildContext).insert(bottomOverlayEntry);
   }



  OnPlayListener onPlayListener;
  void setOnPlayListener(OnPlayListener onPlayListener){
     this.onPlayListener=onPlayListener;
  }

}