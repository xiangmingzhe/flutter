package com.example.flutter_app.plugin;

import android.app.Activity;
import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;

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
    private static final String TAG = "SendMessagePlugin";
    static final int PLAY_MUSIC = 0; //播放歌曲
    static final int UPDATE_PLAY_ICON = 1;//更新播放歌曲icon
    static final int LOCK_SCREEN = 2;//锁屏相关

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
                String json = getJsonString(String.valueOf(UPDATE_PLAY_ICON), String.valueOf(playStatus));
                Log.d("---", "json:" + json);
                sendMessage(json,eventSink);

            }

            @Override
            public void onReadLrc(String lrc) {
                Log.d("---", lrc);
                String json = getJsonString(String.valueOf(PLAY_MUSIC), lrc);
                sendMessage(json,eventSink);

            }
        });
        MediaPlayerTools.getInstance().setOnScreenListener(new MediaPlayerTools.OnScreenListener() {
            @Override
            public void onScreenOn() {
                Log.d(TAG, "*****************开屏");
                String json = getJsonString(String.valueOf(LOCK_SCREEN), "1");
                Log.d("---", "json:" + json);
                sendMessage(json,eventSink);

            }

            @Override
            public void onScreenOff() {
                Log.d(TAG, "*****************锁屏");
                String json = getJsonString(String.valueOf(LOCK_SCREEN), "2");
                Log.d("---", "json:" + json);
                sendMessage(json,eventSink);

            }

            @Override
            public void onUserPresent() {
                Log.d(TAG, "*****************解锁");
                String json = getJsonString(String.valueOf(LOCK_SCREEN), "3");
                Log.d("---", "json:" + json);
                sendMessage(json,eventSink);
            }
        });

    }

    @Override
    public void onCancel(Object o) {

    }

    private String getJsonString(String head, String body) {
        try {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("head", head);
            jsonObject.put("body", body);
            String json = jsonObject.toString();
            Log.d("---", "json:" + json);
            return json;
        } catch (Exception e) {
        }
        return "";
    }
    private void sendMessage(String json,EventChannel.EventSink eventSink){
        if(!TextUtils.isEmpty(json)){
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {

                    eventSink.success(json);

                }
            });
        }
    }
}
