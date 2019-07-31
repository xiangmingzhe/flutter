import 'package:flutter/material.dart';
import 'package:flutter_app/model/BannerBean.dart';
import 'dart:async';
import 'package:meta/meta.dart';

class BannerWidget extends StatefulWidget {
  // banner 数据实体集合
  List<BannerBean> bannerData;

  // banner 默认高度
  double bannerHeight;

  // banner 默认展示时间（毫秒）
  int bannerDuration;

  // banner 切换速度（毫秒）
  int bannerSwitch;

  // 图片加载器
  Build bannerBuild;

  // 点击事件回调接口
  OnBannerPress bannerPress;

  BannerWidget(
      {Key key,
      @required this.bannerData,
      this.bannerHeight,
      this.bannerDuration,
      this.bannerSwitch,
      this.bannerPress,
      this.bannerBuild})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => BannerWidgetState();
}

const CountMax = 0x7fffffff;

typedef void OnBannerPress(int position, BannerBean entity);
typedef Widget Build(int position, BannerBean entity);

class BannerWidgetState extends State<BannerWidget> {
  // 定时器
  Timer bannerTimer;

  // 当前 banner 页下标
  int bannerIndex = 0;

  // 控制器
  PageController bannerController;

  @override
  void initState() {
    super.initState();
    int length = widget.bannerData.length>0?widget.bannerData.length:0;
    double current = (CountMax / 2) - ((CountMax / 2) % length);
    print("*****************");
    print(current);
    print("*****************2");
  if(widget.bannerData!=null&&widget.bannerData.length>0){
    bannerController = PageController(initialPage: current.toInt());
  }else{
    bannerController = PageController(initialPage: 0);
  }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.bannerHeight,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
//          res(),
          viewPages(),
          viewTips()
        ],
      ),
    );
  }

  /**
   * banner 图片组件
   * */
//  Widget viewPages() {
//    return PageView.builder(
//      itemCount: CountMax,
//      controller: bannerController,
//      onPageChanged: onPageChanged,
//      itemBuilder: (context, index) {
//        return InkWell(
//            onTap: () {
//              if (null != widget.bannerPress) {
//                widget.bannerPress(bannerIndex, widget.bannerData[bannerIndex]);
//              }
//            },
//            child: widget.bannerBuild == null
//                ? FadeInImage.memoryNetwork(
//                    height: 100,
//                    image: widget
//                        .bannerData[index % widget.bannerData.length].bannerUrl,
//                    fit: BoxFit.fitWidth)
//                : widget.bannerBuild(index,
//                    widget.bannerData[index % widget.bannerData.length]));
//      },
//    );
//  }

  Widget viewPages() {
         return Scaffold(
        body: Container(
          height: 120.0, //确保pageview的高度
          child: PageView.builder(
            controller: bannerController,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    if (null != widget.bannerPress) {
                      widget.bannerPress(
                          bannerIndex, widget.bannerData[bannerIndex]);
                    }
                  },
                  child: widget.bannerBuild == null
                      ? memoryImage(index)
                      : widget.bannerBuild(index,
                      widget.bannerData[index % widget.bannerData.length]));
            },
            onPageChanged: onPageChanged,
            reverse: false, //是否反转页面的顺序
          ),
        ),
      );


  }
  Widget memoryImage(int index){
    if(widget!=null&&widget.bannerData!=null&&widget.bannerData.length>0){
      return FadeInImage.memoryNetwork(
          image: widget
              .bannerData[index % widget.bannerData.length]
              .bannerUrl,
          fit: BoxFit.fitWidth

      );
    }
    return null;
}
  Build loadImage(int index){
    widget.bannerBuild(index,
      widget.bannerData[index % widget.bannerData.length]);
}
  /**
   * 更新坐标与图片
   * */
  void onPageChanged(index) {
    bannerIndex = index % widget.bannerData.length;
    setState(() {});
  }

  /**
   * banner 小原点组件
   * */
  Widget viewTips() {
    if (widget.bannerData.length <= 1) {
      return Align();
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 0,
        padding: EdgeInsets.all(5.0),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(widget.bannerData[bannerIndex].bannerTitle,
                style: TextStyle(color: Colors.white)),
            Row(
              children: bannerCircle(),
            )
          ],
        ),
      ),
    );
  }

  /**
   * 绘制小圆点并组成集合返回
   * */
  List<Widget> bannerCircle() {
    List<Widget> circleList = [];
    for (var i = 0; i < widget.bannerData.length; i++) {
      circleList.add(Container(
        margin: EdgeInsets.all(3.0),
        width: 5.0,
        height: 5.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bannerIndex == i ? Colors.deepOrange : Colors.white,
        ),
      ));
    }
    return circleList;
  }

  /**
   * 启动计时器
   * */
  void start() {
    if (null != bannerTimer && bannerTimer.isActive) {
      stop();
    }

    if (null == widget.bannerData || widget.bannerData.length <= 1) {
      return;
    }

    bannerTimer = Timer.periodic(Duration(milliseconds: widget.bannerDuration),
        (bannerTimer) {
      bannerController.animateToPage(bannerController.page.toInt() + 1,
          duration: Duration(milliseconds: widget.bannerSwitch),
          curve: Curves.linear);
    });
  }

  /**
   * 停止计时器
   * */
  void stop() {
    bannerTimer?.cancel();
    bannerTimer = null;
  }

  /**
   * 释放资源
   * */
  @override
  void dispose() {
    stop();
    bannerController?.dispose();
    super.dispose();
  }
}

/**
 * @des banner 组件抽象类
 * @author liyongli 20190702
 * */
abstract class BannerBeanUtils {
  // 获取 banner 地址
  get bannerUrl;

  // 获取 banner 介绍
  get bannerTitle;
}
