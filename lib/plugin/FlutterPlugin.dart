import 'package:flutter/services.dart';
class FlutterToastPlugin{
  static const _platform=const MethodChannel("com.mrper.framework.plugins/toast");
  static void showToast(String msg){
    _platform.invokeMethod("showall",{"msg",msg});
  }
}