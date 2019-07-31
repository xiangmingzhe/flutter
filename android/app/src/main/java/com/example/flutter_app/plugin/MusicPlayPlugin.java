package com.example.flutter_app.plugin;

import android.app.Activity;
import android.util.Log;
import android.widget.Toast;

import com.example.flutter_app.tools.MediaPlayerTools;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;

import io.flutter.plugin.common.PluginRegistry;

/**
 * Time:2019/7/31
 * Author:xmz-dell
 * Description:
 */
public class MusicPlayPlugin implements MethodChannel.MethodCallHandler{
    private Activity mActivity;
    private MethodChannel.Result result;
    private static String TAG="MusicPlayPlugin";
    public static String CHANNEL = "com.mrper.framework.plugins/music"; // 分析1
    public static void registerWith(PluginRegistry.Registrar registrar){
        final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL);
        channel.setMethodCallHandler(new MusicPlayPlugin(registrar.activity()));
    }
    public MusicPlayPlugin(Activity mActivity){
        this.mActivity=mActivity;
    }
    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        Log.d(TAG,"methodCall.argument(\"url\"):"+methodCall.argument("url"));
        this.result=result;
        switch (methodCall.method){
            case "play":
                Log.d(TAG,"methodCall.argument(\"url\"):"+methodCall.argument("url"));
                MediaPlayerTools.getInstance().play(methodCall.argument("url"));
                break;
            case "stop":
                break;
            case "onPause":
                MediaPlayerTools.getInstance().pause();
                break;
            case "onDestory":
                break;
            default:
                break;
        }
    }
}
