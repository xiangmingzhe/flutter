import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/http/Config.dart';
import 'package:flutter_app/model/singer/singer.dart';
import 'package:flutter_app/ui/singer/SingerList.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SingerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SingerPageState();
  }
}

class SingerPageState extends State<SingerPage> with AutomaticKeepAliveClientMixin{
  Singer singer;

  @override
  void initState() {
    // TODO: implement initState
    getSingerData(Config.CLASSIFICATION_OF_SINGERS);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('我监听到底部了!');
      }
    });
    super.initState();
  }

  Future<dynamic> getSingerData(String url) async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    print("getSingerData.responseBody:" + responseBody);
    Singer mSinger = Singer.fromJson(json.decode(responseBody));
    // 刷新页面
    setState(() {
      if (mSinger != null && mSinger.list != null && mSinger.list.length > 0) {
        singer = mSinger;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _gridView();
  }

  Widget mGridView;
  ScrollController _scrollController = new ScrollController();

  // 下拉刷新数据
  Future<Null> _refreshData() async {
    getSingerData(Config.CLASSIFICATION_OF_SINGERS);
  }
  Widget _gridView() {
      mGridView=new GridView.count(crossAxisSpacing: 5.0,mainAxisSpacing: 5.0,
        padding: EdgeInsets.all(10.0),crossAxisCount: 3,
        childAspectRatio: 1.0,
        children: getWidgetList(),
      );

    return mGridView;

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: Container(
        color: Colors.grey[100],
        child: StaggeredGridView.countBuilder(
          controller: _scrollController,
          crossAxisCount: 4,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          primary: false,
          itemCount: singer != null && singer.list != null && singer.list.length > 0
              ? singer.list.length
              : 0,
          itemBuilder: (context, index) => Image.network(
            singer.list[index].imgurl,
          ),
          staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 1),
        ),
      ),
    );

//    getWidgetList();
//    mGridView = new StaggeredGridView.countBuilder(
//      controller: _scrollController,
//      crossAxisCount: 4,
//      crossAxisSpacing: 4.0,
//      mainAxisSpacing: 4.0,
//      primary: false,
//      itemCount: singer != null && singer.list != null && singer.list.length > 0
//          ? singer.list.length
//          : 0,
//      itemBuilder: (context, index) => Image.network(
//        singer.list[index].imgurl,
//      ),
//      staggeredTileBuilder: (int index) =>
//          new StaggeredTile.count(2, index.isEven ? 2 : 1),
//    );
//    return mGridView;
  }

  List<Widget> getWidgetList() {
    List<Widget> gridViewList = new List();
    if (singer != null && singer.list.length > 0) {
      //循环建立多数据
      singer.list.forEach((f) {
        gridViewList.add(getItemView(f.imgurl, f.classid));
      });
      singer.list.forEach((f) {
        gridViewList.add(getItemView(f.imgurl, f.classid));
      });
      singer.list.forEach((f) {
        gridViewList.add(getItemView(f.imgurl, f.classid));
      });
    } else {
      gridViewList.add(getItemView(
          "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=717747993,1697525243&fm=15&gp=0.jpg",
          0));
    }
    return gridViewList;
  }

  Widget getItemView(String itemUrl, int mClassid) {
    return new GestureDetector(
      child: new Container(
        alignment: Alignment.center,
        child: Image.network(
          itemUrl,
          width: 700,
          height: 700,
        ),
      ),
      onTap: () {
        // push的调用方法
        Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) =>
                  new SingerList(classid: mClassid.toString()),
            ));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
