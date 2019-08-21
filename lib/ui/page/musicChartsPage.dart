import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/rankmusic/rankmusic.dart';

/**
 * 音乐排行榜
 */
class MusicChart extends StatefulWidget {
  @override
  MusicChartsState createState() => MusicChartsState();

}

class MusicChartsState extends State<MusicChart> with SingleTickerProviderStateMixin {
  ListView listView;
  List<RankMusicInfo> rankList;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    getMusicRankingListData(MUSIC_RANK_LIST_DATA_URL);
    return new Container(child: _widget(),);
  }
  var MUSIC_RANK_LIST_DATA_URL = "http://m.kugou.com/rank/list&json=true";
  Future<dynamic> getMusicRankingListData(var url) async {
    if(rankList!=null&&rankList.length>0){
      return;
    }
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
//    print("getMusicRankingListData.responseBody:" + responseBody);
    RankMusic rankMusic = RankMusic.fromJson(json.decode(responseBody));
    // 刷新页面
    setState(() {
      if (rankMusic.rank != null &&
          rankMusic.rank.list != null &&
          rankMusic.rank.list.length > 0) {
        rankList = rankMusic.rank.list;
      }
    });
    print("**********************rankList.length");
    print(rankList.length);
  }


  Widget _widget(){
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