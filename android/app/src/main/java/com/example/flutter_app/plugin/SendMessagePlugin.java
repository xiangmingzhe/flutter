package com.example.flutter_app.plugin;

import android.app.Activity;

import com.example.flutter_app.tools.MediaPlayerTools;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * Time:2019/8/1
 * Author:xmz-dell
 * Description:
 */
public class SendMessagePlugin implements EventChannel.StreamHandler{
   private Activity activity;
   static EventChannel channel;
    private SendMessagePlugin(Activity activity){
        this.activity=activity;
    }
    public static void registerWith(PluginRegistry.Registrar registrar){
        channel=new EventChannel(registrar.messenger(),CHANNEL);
        SendMessagePlugin instance=new SendMessagePlugin(registrar.activity());
        channel.setStreamHandler(instance);
    }
   public static String CHANNEL="com.flutter.app/sendmessageplugin";

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        MediaPlayerTools.getInstance().setOnMediaPlayListener(new MediaPlayerTools.OnMediaPlayListener() {
            @Override
            public void onPlayStatus(int playStatus) {
                eventSink.success(playStatus);
            }
        });
    }

    @Override
    public void onCancel(Object o) {

    }
}
