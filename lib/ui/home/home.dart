import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/dialog/bottom/bottomdialog.dart';
import 'package:flutter_app/dialog/customdialog.dart';
import 'package:flutter_app/http/Config.dart';
import 'package:flutter_app/model/BannerBean.dart';
import 'package:flutter_app/model/lrc/songInfoLrc.dart';
import 'package:flutter_app/model/lrc/songlrc.dart';
import 'package:flutter_app/model/rankmusic/rankmusic.dart';
import 'package:flutter_app/model/song/SongInfoModel.dart';
import 'package:flutter_app/ui/play/play_details.dart';
import 'package:flutter_app/widget/banner_page.dart';
import 'package:path/path.dart';

import 'package:flutter/services.dart';

import 'dart:io';
import 'dart:convert'; // 数据解析
import 'package:flutter_app/model/song/newSongModel.dart';

class MusicTable {
  String text;
  String tab;

  MusicTable(this.text, this.tab);
}

final List<MusicTable> musicList = <MusicTable>[
  new MusicTable("音乐新歌榜", "Song"),
  new MusicTable("音乐排行榜", "Song"),
  new MusicTable("歌曲", "Song"),
  new MusicTable("文件夹", "Folder"),
  new MusicTable("专辑", "Album"),
];

/**
 * banner 点击事件监听
 * */
void _bannerPress(int position, BannerBean entity) {
  print(position);
  print(entity.titleStr + entity.imageUrl);
}

//声明一个调用对象，需要把kotlin中注册的ChannelName传入构造函数
const _platform = const MethodChannel('com.mrper.framework.plugins/toast');
const _musicPlatform = const MethodChannel('com.mrper.framework.plugins/music');
const sendMessagePlugin =
    const EventChannel('com.flutter.app/sendmessageplugin');
const _lrcPlatform = const MethodChannel('com.mrper.framework.plugins/lrc');

StreamSubscription _subscription = null;

var _count;
var iconUrl;
SongInfo songInfo;
BottomDialog bottomDialog;

class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
  AppLifecycleState _lastLifecycleState;





}

/**
 * 获取歌词信息
 */
Future<dynamic> getLrc(var url) async {
  var httpClient = new HttpClient();
  var request = await httpClient.getUrl(Uri.parse(url));
  var response = await request.close();
  var responseBody = await response.transform(Utf8Decoder()).join();
  print("getLrc.responseBody:" + responseBody);
  SongLrc songLrc = SongLrc.fromJson(json.decode(responseBody));
  if (songLrc != null) {
    String lrcId = songLrc.candidates[0].id;
    String lrcAccesskey = songLrc.candidates[0].accesskey;
    String url = "http://lyrics.kugou.com/download?ver=1&client=pc&id=" +
        lrcId +
        "&accesskey=" +
        lrcAccesskey +
        "&fmt=krc&charset=utf8";

    getLrcInfo(url, songLrc.candidates[0].accesskey);
  }
}

/**
 * 获取歌词详细信息
 */
Future<dynamic> getLrcInfo(var url, var hashCode) async {
  var httpClient = new HttpClient();
  var request = await httpClient.getUrl(Uri.parse(url));
  var response = await request.close();
  var responseBody = await response.transform(Utf8Decoder()).join();
  print("getLrcInfo-----url:"+url);
  print("getLrcInfo.responseBody:" + responseBody);
  SongInfoLrc songInfoLrc = SongInfoLrc.fromJson(json.decode(responseBody));
  if (songInfoLrc != null) {
    print("songInfoLrc != null:");

    _lrcPlatform
        .invokeMethod('lrc', {'lrc': songInfoLrc.content, 'lrcName': hashCode});
  }
}

/**
 * 获取歌曲详细信息
 */
Future<dynamic> getSongInfo(var url, BuildContext context, var hashCode) async {
  var loadingDialog = new LoadingDialog(
    outsideDismiss: true,
    dismissCallback: _disMissCallBack(context),
  );
  loadingDialog.initDialog();
  loadingDialog.createState();
  showDialog(
      context: context,
      builder: (context) {
        return loadingDialog;
      });
  var httpClient = new HttpClient();
  var request = await httpClient.getUrl(Uri.parse(url));
  var response = await request.close();
  var responseBody = await response.transform(Utf8Decoder()).join();
  print("getSongInfo.responseBody:" + responseBody);
  try {
    songInfo = SongInfo.fromJson(json.decode(responseBody));
  } catch (e) {
    _platform.invokeMethod('showall', {'msg': "接口异常"}); //调用相应方法，并传入相关参数。
    initVirtualData();
    loadingDialog.dialog.dimissDialog();
  }
  if (songInfo != null) {
    getLrc(Config.SONG_GET_LRC_URL + hashCode);

  } else {
    loadingDialog.dialog.dimissDialog();
  }
}

/**
 * 构造虚拟数据
 */
void initVirtualData() {
  songInfo = new SongInfo();
  songInfo.imgUrl =
      "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=717747993,1697525243&fm=15&gp=0.jpg";
  songInfo.albumImg="https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2972144875,3220556455&fm=26&gp=0.jpg";
  songInfo.hash = "CB7EE97F4CC11C4EA7A1FA4B516A5D97";
  songInfo.songName = "刚好遇见你";
  songInfo.singerName = "李玉刚";
  songInfo.url =
      "http://www.ytmp3.cn/down/65892.mp3";
}
var playContext;
void playMusic(String lrc) {
  var imageUrl = songInfo.albumImg.replaceAll("{size}", "");
  _musicPlatform
      .invokeMethod('play', {'url': "${songInfo.url}"}); //调用相应方法，并传入相关参数。
  if (bottomDialog == null) {
    bottomDialog = new BottomDialog();
    bottomDialog.updateDialogData(
        imageUrl, songInfo.songName, songInfo.singerName,lrc);
    bottomDialog.showBottomDialog(playContext, _platform, _musicPlatform);
  } else {
    bottomDialog.updateDialogData(
        imageUrl, songInfo.songName, songInfo.singerName,lrc);
  }

}

//这个func 就是关闭Dialog的方法
_disMissCallBack(BuildContext context) {}

class _testState extends State<test> with WidgetsBindingObserver{
  AppLifecycleState _lastLifecycleState;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("didChangeAppLifecycleState build");
    print(state);
    print("didChangeAppLifecycleState build stop");

  }
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  List<Data> songlist;

  // ignore: ambiguous_import
  Autogenerated mAutogenerated;
  List<RankMusicInfo> rankList;
  int firstLoad = 0;

  Future<dynamic> getMusicData(var url) async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    print("getMusicData.responseBody:" + responseBody);
    Autogenerated autogenerated =
        Autogenerated.fromJson(json.decode(responseBody));
    print("autogenerated:" + autogenerated.kgDomain);

    // 刷新页面
    setState(() {
      songlist = autogenerated.data;
      mAutogenerated = autogenerated;
      firstLoad = 1;
    });
  }

  Future<dynamic> getMusicRankingListData(var url) async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    print("getMusicRankingListData.responseBody:" + responseBody);
    RankMusic rankMusic = RankMusic.fromJson(json.decode(responseBody));
    // 刷新页面
    setState(() {
      if (rankMusic.rank != null &&
          rankMusic.rank.list != null &&
          rankMusic.rank.list.length > 0) {
        rankList = rankMusic.rank.list;
      }
    });
  }

  var MUSIC_DATA_URL = "http://m.kugou.com/?json=true";
  var MUSIC_RANK_LIST_DATA_URL = "http://m.kugou.com/rank/list&json=true";

  void _onEvent(Object event) {
    setState(() {
      if (event.toString().length > 1) {
        playMusic(event.toString());
      } else {
        _count = event;
        print("ChannelPage: $event");
        if (_count == 0) {
          //播放
          iconUrl = "images/s_pause.png";
        } else if (_count == 2) {
          //暂停
          iconUrl = "images/s_play.png";
        }
        bottomDialog.updateIocn(_count);
      }
    });
  }

  void _onError(Object error) {
    setState(() {
      _count = "计时器异常";
      print(error);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    //开启监听
    if (_subscription == null) {
      _subscription = sendMessagePlugin
          .receiveBroadcastStream()
          .listen(_onEvent, onError: _onError);
    }
  }

  DateTime lastPopTime;
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("重新deactivate...");

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("重新build...");
    if (firstLoad == 0) {
      getMusicData(MUSIC_DATA_URL);
    }
    SelectView selectView = new SelectView(songlist, mAutogenerated, rankList);
    return new MaterialApp(
        home: new DefaultTabController(
            //tab的数量  该字段必须有
            length: musicList.length,
            child: new Scaffold(
              appBar: new AppBar(
                title: new Text('flutter音乐'),
                backgroundColor: Colors.amber,
                bottom: new TabBar(
                  //迭代items 并生成Tab对象
                  onTap: (int i) {
                    curPosition = i;
                    switch (i) {
                      case 0:
                        getMusicData(MUSIC_DATA_URL);
                        break;
                      case 1:
                        getMusicRankingListData(MUSIC_RANK_LIST_DATA_URL);
                        break;
                    }
                  },
                  tabs: musicList.map((MusicTable item) {
                    return new Tab(text: item.text);
                  }).toList(),
                  //是否可以滚动
                  isScrollable: true,
                ),
              ),
              body: new TabBarView(
                  children: musicList.map((MusicTable item) {
                return new Padding(
                  padding: EdgeInsets.all(16),
                  child: new Center(child: selectView),
                );
              }).toList()),
            )));

//    return WillPopScope(
//        child: Scaffold(
//          body: Center(
//            child: new MaterialApp(
//                home: new DefaultTabController(
//                    //tab的数量  该字段必须有
//                    length: musicList.length,
//                    child: new Scaffold(
//                      appBar: new AppBar(
//                        title: new Text('flutter音乐'),
//                        backgroundColor: Colors.amber,
//                        bottom: new TabBar(
//                          //迭代items 并生成Tab对象
//                          onTap: (int i) {
//                            curPosition = i;
//                            switch (i) {
//                              case 0:
//                                getMusicData(MUSIC_DATA_URL);
//                                break;
//                              case 1:
//                                getMusicRankingListData(
//                                    MUSIC_RANK_LIST_DATA_URL);
//                                break;
//                            }
//                          },
//                          tabs: musicList.map((MusicTable item) {
//                            return new Tab(text: item.text);
//                          }).toList(),
//                          //是否可以滚动
//                          isScrollable: true,
//                        ),
//                      ),
//                      body: new TabBarView(
//                          children: musicList.map((MusicTable item) {
//                        return new Padding(
//                          padding: EdgeInsets.all(16),
//                          child: new Center(child: selectView),
//                        );
//                      }).toList()),
//                    ))),
//          ),
//        ),
//        onWillPop: () async {
//          if (lastPopTime == null ||
//              DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
//            lastPopTime = DateTime.now();
//            _platform
//                .invokeMethod('showall', {'msg': "再按一次退出"}); //调用相应方法，并传入相关参数。
//          } else {
//            lastPopTime = DateTime.now();
//            // 退出app
//            await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//          }
//        });
  }
}

List<BannerBean> bannerList = new List();
var curPosition = 0;

class SelectView extends StatelessWidget {
  List<Data> songlist;
  List<RankMusicInfo> rankList;
  Autogenerated mAutogenerated;

  SelectView(this.songlist, this.mAutogenerated, this.rankList);

  // 跨域访问

  // banner 数据集合
  List<BannerBean> bannerData;
  GlobalKey<BannerWidgetState> globalKey = new GlobalKey<BannerWidgetState>();

  /**
   * 初始化 banner 数据
   * */
  List<BannerBean> _initBannerData() {
    if (mAutogenerated != null &&
        mAutogenerated.banner != null &&
        mAutogenerated.banner.length > 0) {
      bannerList.clear();
      for (var item in mAutogenerated.banner) {
        bannerList.add(new BannerBean(
            imageUrl: item.imgurl, titleStr: "flutter云音乐", intentType: 0));
      }
    } else {
      bannerList.add(new BannerBean(
          imageUrl:
              "http://img.pconline.com.cn/images/upload/upc/tx/bbs6/1010/24/c1/5622801_1287922101936_1024x1024.jpg",
          titleStr: "flutter云音乐",
          intentType: 0));
    }
    // 2 秒后启动轮播
    Timer timer;
    timer = new Timer(new Duration(milliseconds: 200), () {
      if (globalKey != null) {
        globalKey.currentState.start();
      }
      timer.cancel();
      timer = null;
    });

    return bannerList;
  }

  BannerWidget bannerWidget;

  @override
  Widget build(BuildContext context) {
    Widget titleSection;
    if (curPosition == 0) {
      titleSection = Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1, //pageview 所占布局比
              child: getBannerWidget(),
            ),
            Expanded(
                flex: 3, //listview 所占布局比
                child: SongMusicListview(context))
          ],
        ),
      );
    } else {
      titleSection = Container(
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 3, //listview 所占布局比
                child: SongMusicListview(context))
          ],
        ),
      );
    }

    return titleSection;
  }

  BannerWidget getBannerWidget() {
    if (bannerWidget == null) {
      bannerWidget = new BannerWidget(
        key: globalKey,
        bannerData: _initBannerData(),
        bannerDuration: 5000,
        bannerSwitch: 500,
        bannerPress: _bannerPress,
        bannerBuild: (position, BannerBean) {
          if (BannerBean != null)
            return Image.network(BannerBean.bannerUrl, fit: BoxFit.fitWidth);
        },
      );
    }
    return bannerWidget;
  }

  /**
   *  构建listview
   */
  Widget SongMusicListview(BuildContext context) {
    playContext=context;
    ListView listView;
    switch (curPosition) {
      case 0:
        listView = new ListView.builder(
            itemCount:
                (songlist != null && songlist.length > 0 ? songlist.length : 0),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return new ListTile(
                leading: new Icon(Icons.branding_watermark),
                title: new Text("${songlist[index].filename}"),
                onTap: () {
                  getSongInfo(Config.SONG_INFO_URL + songlist[index].hash,
                      context, songlist[index].hash);
                },
              );
            });
        break;
      case 1:
        listView = new ListView.builder(
            itemCount:
                rankList != null && rankList.length > 0 ? rankList.length : 0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return new ListTile(
                contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 2.0, 2.0),
                leading: new Image.network(getRankUrl(index)),
                title: new Text("${rankList[index].rankname}"),
                onTap: () {},
              );
            });
        break;
    }

    return listView;
  }

  /**
   * 获取酷狗音乐排行榜图标url
   */
  String getRankUrl(int index) {
    var imageUrl = rankList[index].imgurl.replaceAll("{size}", "");
    print("getRankUrl:" + imageUrl);
    return imageUrl;
  }
}

//Future requestPermission(BuildContext context) async {
//  // 申请权限
//
//  Map<PermissionGroup, PermissionStatus> permissions =
//  await PermissionHandler().requestPermissions([PermissionGroup.storage]);
//
//  // 申请结果  权限检测
//  PermissionStatus permission =
//  await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
//
//  if (permission == PermissionStatus.granted) {
//    // 参数1：提示消息
//// 参数2：提示消息多久后自动隐藏
//// 参数3：位置
//    Toast.show("权限申请通过！", context,
//        duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
//  } else {
//    Toast.show("权限申请被拒绝！", context,
//        duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
//  }
//}
