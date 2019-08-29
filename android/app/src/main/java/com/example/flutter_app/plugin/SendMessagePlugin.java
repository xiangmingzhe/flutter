package com.example.flutter_app.plugin;

import android.app.Activity;

import com.example.flutter_app.model.fnative.Fnative;
import com.example.flutter_app.tools.MediaPlayerTools;

import org.json.JSONObject;

import io.flutter.Log;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * Time:2019/8/1
 * Author:xmz-dell
 * Description:
 */
public class SendMessagePlugin implements EventChannel.StreamHandler {
    private Activity activity;
    static EventChannel channel;

    final int PLAY_MUSIC = 0;
    final int UPDATE_PLAY_ICON = 1;

    private SendMessagePlugin(Activity activity) {
        this.activity = activity;
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        channel = new EventChannel(registrar.messenger(), CHANNEL);
        SendMessagePlugin instance = new SendMessagePlugin(registrar.activity());
        channel.setStreamHandler(instance);
    }

    public static String CHANNEL = "com.flutter.app/sendmessageplugin";

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        MediaPlayerTools.getInstance().setOnMediaPlayListener(new MediaPlayerTools.OnMediaPlayListener() {
            @Override
            public void onPlayStatus(int playStatus) {
                try {
                    JSONObject jsonObject=new JSONObject();
                    jsonObject.put("head",String.valueOf(UPDATE_PLAY_ICON));
                    jsonObject.put("body",String.valueOf(playStatus));
                    String json=jsonObject.toString();
                    Log.d("---", "json:"+json);
                    eventSink.success(json);
                }catch (Exception e){
                }
            }

            @Override
            public void onReadLrc(String lrc) {
                Log.d("---", lrc);
                try {
                    JSONObject jsonObject=new JSONObject();
                    jsonObject.put("head",String.valueOf(PLAY_MUSIC));
                    jsonObject.put("body",lrc);
                    String json=jsonObject.toString();
                    Log.d("---", "json:"+json);

                    eventSink.success(json);

                }catch (Exception e){

                }

            }
        });


    }

    @Override
    public void onCancel(Object o) {

    }
}
