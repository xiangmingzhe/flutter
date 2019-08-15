import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/dialog/customdialog.dart';
import 'package:flutter_app/model/song/SongInfoModel.dart';
import 'package:flutter_app/widget/banner_page.dart';
import 'package:path/path.dart';
import 'http/ServerApi.dart';
import 'model/BannerBean.dart';
import 'model/rankmusic/rankmusic.dart';
import 'model/song/newSongModel.dart';
import 'package:flutter/services.dart';

import 'dart:io';
import 'dart:convert'; // 数据解析
import 'package:flutter_app/model/song/newSongModel.dart';
import 'http/Config.dart';

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
const sendMessagePlugin = const EventChannel('com.flutter.app/sendmessageplugin');

StreamSubscription _subscription = null;

var _count;
SongInfo songInfo;

class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

Future<dynamic> getSongInfo(var url, BuildContext context) async {
  var loadingDialog=new LoadingDialog(
    outsideDismiss: true,
    dismissCallback: _disMissCallBack(context),
  );
  loadingDialog.initDialog();
  loadingDialog.createState();
   showDialog(
       context: context,
       builder: (context) {
         return loadingDialog;
       }
   );
  var httpClient = new HttpClient();
  var request = await httpClient.getUrl(Uri.parse(url));
  var response = await request.close();
  var responseBody = await response.transform(Utf8Decoder()).join();
  print("getSongInfo.responseBody:" + responseBody);
  songInfo = SongInfo.fromJson(json.decode(responseBody));
  if (songInfo != null) {
    var imageUrl = songInfo.albumImg.replaceAll("{size}", "");
    print("url:" + "${songInfo.url}" + "---" + songInfo.albumImg);
    _musicPlatform
        .invokeMethod('play', {'url': "${songInfo.url}"}); //调用相应方法，并传入相关参数。
    showBottomDialog(context, imageUrl, songInfo.songName, songInfo.singerName);
    loadingDialog.dialog.dimissDialog();
  }
}
//这个func 就是关闭Dialog的方法
_disMissCallBack(BuildContext context) {
//  Navigator.of(context, rootNavigator: true).pop();
//  Navigator.of(context).pop();
//  Navigator.pop(context);

}


OverlayEntry bottomOverlayEntry;
/**
 * 展示微信下拉的弹窗
 */
void showBottomDialog(BuildContext buildContext, String imageUrl,
    String songName, String singerName) {

  bottomOverlayEntry = new OverlayEntry(builder: (context) {
    return new Positioned(
        bottom: 0,
        width: 700,
        height: 90,
        child: new SafeArea(
            child: new Material(
            child: GestureDetector(
              onTap: () {
              _platform.invokeMethod('showall', { 'msg': "点击了悬浮栏"}); //调用相应方法，并传入相关参数。
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
                            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 2.0, 2.0),
                          )
//                    new Positioned(top: 20,width: 60,height: 60,child: new Text(songName)),new Positioned(bottom: 20,width: 60,height: 60,child: new Text(singerName))
                        ],
                      )),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        InkWell(
                          child: new Image(
                              image: new AssetImage("images/s_pause.png")),
                          onTap: () {
                            _musicPlatform.invokeMethod(
                                'onPause', {'url': null}); //调用相应方法，并传入相关参数。
                          },
                        )
                      ],
                    ),
                    padding: const EdgeInsets.fromLTRB(100.0, 2.0, 2.0, 2.0),
                  )
                ],
              ),
            ),
            ),
        )));
  });
  Overlay.of(buildContext).insert(bottomOverlayEntry);
}

class _testState extends State<test> {
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
      _count = event;
      print("ChannelPage: $event");
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
    //开启监听
    if(_subscription == null){
      _subscription =  sendMessagePlugin.receiveBroadcastStream().listen(_onEvent,onError: _onError);
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                title: new Text('网易音乐'),
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
                    return new Tab(text: item.text
//                        icon: new Icon(item.icon),
                        );
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
      for (var item in mAutogenerated.banner) {
        if (bannerList.length > 5) {
          break;
        }
        bannerList.add(new BannerBean(
            imageUrl: item.imgurl, titleStr: "网易云音乐", intentType: 0));
      }
    }

    // 2 秒后启动轮播
    Timer timer;
    timer = new Timer(new Duration(seconds: 10), () {
//      globalKey.currentState.start();
      timer.cancel();
      timer = null;
    });

    return bannerList;
  }

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1, //pageview 所占布局比
            child: new BannerWidget(
              key: GlobalKey(),
              bannerData: _initBannerData(),
              bannerDuration: 5000,
              bannerSwitch: 500,
              bannerPress: _bannerPress,
              bannerBuild: (position, BannerBean) {
                if (BannerBean != null)
                  return Image.network(BannerBean.bannerUrl,
                      fit: BoxFit.fitWidth);
              },
            ),
          ),
          Expanded(
              flex: 3, //listview 所占布局比
              child: SongMusicListview(context))
        ],
      ),
    );
    return titleSection;
  }

  Widget SongMusicListview(BuildContext context) {
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
//                  _platform.invokeMethod('showall', { 'msg': "${songlist[index].filename}"}); //调用相应方法，并传入相关参数。


                  getSongInfo(
                      Config.SONG_INFO_URL + songlist[index].hash, context);
                },
//                subtitle: new Row(
//                  children: <Widget>[
//                    new Icon(Icons.queue_music),
//                    new Text("${songlist[index].extname}")
//
//                  ],
//                ),
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
                leading: new Icon(Icons.branding_watermark),
                title: new Text("${rankList[index].rankname}"),
                onTap: () {},

              );
            });
        break;
    }

    return listView;
  }
}
