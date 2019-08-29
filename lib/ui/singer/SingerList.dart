import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/singer/singer_list_entity.dart';
import 'package:flutter_app/model/singer/singer_list_entity.dart';
import 'package:flutter_app/model/singer/singer_list_entity.dart';
String mClassid;
class SingerList extends StatefulWidget{
  final String classid;
  SingerList({Key key,@required this.classid}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    mClassid=classid;
    return new SingerListState();
  }

}
class SingerListState extends State<StatefulWidget>{

  @override
  void initState() {
    // TODO: implement initState
    getSingerList("http://m.kugou.com/singer/list/"+mClassid+"?json=true");
    super.initState();
  }
  List<SingerListSingersListInfo> singerListSingersList;
  SingerListEntity mSingerListEntity;
  Future<dynamic>getSingerList(var url) async{
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    print("getSingerList.responseBody:" + responseBody);

    SingerListEntity singerListEntity=SingerListEntity.fromJson(json.decode(responseBody));
    if(singerListEntity!=null){
      if(mounted){
        setState(() {
          mSingerListEntity=singerListEntity;
          singerListSingersList=singerListEntity.singers.xList.info;
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {

    // TODO: implement build
//    return new Container(child: _getContentView(),color: Colors.white,);
//  return new Container(child: new Center(child: _getContentView(),),color: Colors.white,);
//  return new Container(child: new Column(children: <Widget>[new AppBar(title: new Text("热门歌曲"),),_getContentView(),],),color: Colors.white,);
    return new MaterialApp(
      home: new Scaffold(
      appBar: new AppBar(title: new Text(mSingerListEntity!=null&&mSingerListEntity.classname.length>0?mSingerListEntity.classname:"热门"
      ),backgroundColor: Colors.amber,
          ),
        body: new Center(child: _getContentView(),),
    ),

    );
  }


  Widget listView;
  Widget _getContentView(){
    return new ListView.builder(
      itemCount:  singerListSingersList!=null&&singerListSingersList.length>0?singerListSingersList.length:0,
      itemBuilder: (BuildContext context, int index) {
        return new Container(
            padding: new EdgeInsets.all(8.0),
            child: new Row(
              children: <Widget>[
                new Image.network(
                  getRankUrl(index)),
                new Padding(padding: new EdgeInsets.all(5.0)),
                new Text("${singerListSingersList[index].singername}",style: TextStyle(color: Colors.yellow,decoration: TextDecoration.none,fontSize: 15),),
              ],
            )
        );
      },
    );
  }
  /**
   * 获取酷狗音乐排行榜图标url
   */
  String getRankUrl(int index) {
    var imageUrl = singerListSingersList[index].imgurl.replaceAll("{size}", "");
    print("getRankUrl:" + imageUrl);
    return imageUrl;
  }
}