import 'package:flutter_app/widget/banner_page.dart';

/**
 * @des banner 组件实体类
 * @author liyongli 20190702
 * */
class BannerBean extends Object with BannerBeanUtils{

  String imageUrl;
  String titleStr;
  int intentType;

  BannerBean({this.imageUrl, this.titleStr, this.intentType});

  @override
  get bannerTitle => titleStr;

  @override
  get bannerUrl => imageUrl;

}