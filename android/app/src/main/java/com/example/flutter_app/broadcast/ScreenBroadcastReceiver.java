package com.example.flutter_app.broadcast;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import com.example.flutter_app.tools.MediaPlayerTools;

/**
 * Time:2019/8/29
 * Author:xmz-dell
 * Description:
 */
public class ScreenBroadcastReceiver extends BroadcastReceiver {
    String action;
    @Override
    public void onReceive(Context context, Intent intent) {
        System.err.println("ScreenBroadcastReceiver************"+action);
        action = intent.getAction();
        if (Intent.ACTION_SCREEN_ON.equals(action)) { // 开屏
            if(MediaPlayerTools.getInstance().onScreenListener!=null){
                MediaPlayerTools.getInstance().onScreenListener.onScreenOn();
            }
        } else if (Intent.ACTION_SCREEN_OFF.equals(action)) { // 锁屏
            if(MediaPlayerTools.getInstance().onScreenListener!=null){
                MediaPlayerTools.getInstance().onScreenListener.onScreenOff();
            }
        } else if (Intent.ACTION_USER_PRESENT.equals(action)) { // 解锁
            if(MediaPlayerTools.getInstance().onScreenListener!=null){
                MediaPlayerTools.getInstance().onScreenListener.onUserPresent();
            }
        }

    }
}
