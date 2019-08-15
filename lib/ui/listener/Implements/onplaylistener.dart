import 'package:flutter/animation.dart';
import 'package:flutter_app/ui/listener/Interface/onPlayListener.dart';

class OnMusicPlayListener implements OnPlayListener{
  AnimationController controller;
  void setAnimationController(AnimationController controller){
    this.controller=controller;
  }
  @override
  void onPause() {
    // TODO: implement onPause
    if(controller!=null){
      controller.stop();
    }
  }

  @override
  void onPlay() {
    // TODO: implement onPlay
    if(controller!=null){
      controller.forward();
    }
  }

}