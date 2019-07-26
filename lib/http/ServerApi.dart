import 'dart:io';
import 'dart:convert'; // 数据解析
import 'package:flutter_app/model/song/newSongModel.dart';
class HttpManager {
//  factory HttpManager()
  // 工厂模式
  factory HttpManager() =>_getInstance();
  static HttpManager get instance => _getInstance();
  static HttpManager _instance;


  HttpManager._internal() {
    // 初始化
  }
  static HttpManager _getInstance() {
    if (_instance == null) {
      _instance = new HttpManager._internal();
    }
    return _instance;
  }
  Future<dynamic> getMusicData(var url) async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    print("responseBody:" + responseBody);
    Autogenerated autogenerated=Autogenerated.fromJson(json.decode(responseBody));
    print("autogenerated:"+autogenerated.kgDomain);
    return autogenerated;
  }

}
abstract class OnloadMusicDataListener{
  void onloadSuccess(Autogenerated autogenerated);
  void onLoadFail();
}
