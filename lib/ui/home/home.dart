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
import 'package:flutter_app/ui/page/musicChartsPage.dart';
import 'package:flutter_app/ui/page/newMusicListPage.dart';
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
  new MusicTable("音乐新歌榜", "newSong"),
  new MusicTable("音乐排行榜", "Song"),
  new MusicTable("歌手", "Singr"),
  new MusicTable("文件夹", "Folder"),
  new MusicTable("专辑", "Album"),
];

class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> with SingleTickerProviderStateMixin {
  TabController _tabController;
  StreamSubscription _subscription = null;
  var _count;
  var iconUrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //开启监听
    if (_subscription == null) {
      _subscription = sendMessagePlugin
          .receiveBroadcastStream()
          .listen(_onEvent, onError: _onError);
    }
    _tabController = TabController(vsync: this, length: musicList.length)
      ..addListener(() {
        if (_tabController.index.toDouble() ==
            _tabController.animation.value) {}
      });
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
    return new MaterialApp(
        home: new Scaffold(
      appBar: new AppBar(
        title: new Text('flutter音乐'),
        backgroundColor: Colors.amber,
        bottom: new TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          //迭代items 并生成Tab对象
          onTap: (int i) {
            curPosition = i;
            switch (i) {
              case 0:
                break;
              case 1:
//                        getMusicRankingListData(MUSIC_RANK_LIST_DATA_URL);
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
      body: TabBarView(controller: _tabController, children: [
        _newMusicListPage(),
        _musicChart(),
        new Text("cccc"),
        new Text("cccc"),
        new Text("ccc2c")
      ]),
    ));
  }
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


}

Widget newMusicListPage;
Widget musicChart;

Widget _newMusicListPage() {
  if (newMusicListPage == null) {
    newMusicListPage = NewMusicListPage();
  }
  return newMusicListPage;
}
Widget _musicChart(){
  if (musicChart == null) {
      musicChart = MusicChart();
  }
  return musicChart;
}

List<BannerBean> bannerList = new List();
var curPosition = 0;


