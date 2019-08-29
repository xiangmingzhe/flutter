import 'dart:async';

import 'package:flutter/material.dart';

class WaveCircle extends CustomPainter{


  Paint mPaint = new Paint()
  ..color=Colors.yellow
  ..strokeCap=StrokeCap.square
  ..isAntiAlias=false
  ..strokeWidth=1.0
  ..style=PaintingStyle.stroke
  ;

  double offsetX1=0.0;
  double offsetY1=0.0;

  double offsetX2=0.0;
  double offsetY2=0.0;

  double offsetX3=0.0;
  double offsetY3=0.0;

  bool isStartTimer=true;
  int position=0;
  Canvas mCanvas;

  double radius1=0.0;
  double radius2=0.0;
  double radius3=0.0;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    mCanvas=canvas;
    mCanvas.drawCircle(Offset(offsetX1, offsetY1), radius1, mPaint);
    mCanvas.drawCircle(Offset(offsetX2, offsetY2), radius2, mPaint);
    mCanvas.drawCircle(Offset(offsetX3, offsetY3), radius3, mPaint);

    startTimer();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
  Timer timer;
  void startTimer(){
    if(timer==null){
      timer = new Timer(new Duration(milliseconds: 1000), () {
        switch(position){
          case 0:
            radius1+=140;
            offsetX1=141.0;
            offsetY1=141.0;
            position=1;
            timer.cancel();
            timer=null;
            startTimer();

            break;
          case 1:
            radius2+=160;
            offsetX2=141.0;
            offsetY2=141.0;
            position=2;
            timer.cancel();
            timer=null;
            startTimer();

            break;
          case 2:
            radius3+=180;
            offsetX3=141.0;
            offsetY3=141.0;
            timer.cancel();
            timer=null;
            startTimer();
            position=3;
            break;
          case 3:
            cleanAllInfo();
            timer.cancel();
            timer=null;
            startTimer();
            position=0;
            break;
        }

      });
    }
  }
  void cleanAllInfo(){
    radius3=0.0;
    radius2=0.0;
    radius1=0.0;

    offsetX3=0.0;
    offsetY3=0.0;

    offsetX2=0.0;
    offsetY2=0.0;

    offsetX1=0.0;
    offsetY1=0.0;

  }
}