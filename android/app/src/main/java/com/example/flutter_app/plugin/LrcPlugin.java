package com.example.flutter_app.plugin;

import android.app.Activity;
import android.util.Log;

import com.example.flutter_app.lrc.LyricAnalysis;
import com.example.flutter_app.tools.MediaPlayerTools;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * Time:2019/8/16
 * Author:xmz-dell
 * Description:
 */
public class LrcPlugin implements MethodChannel.MethodCallHandler{
    private Activity mActivity;
    private MethodChannel.Result result;
    private static String TAG="LrcPlugin";
    public static String CHANNEL = "com.mrper.framework.plugins/lrc"; //
    public static void registerWith(PluginRegistry.Registrar registrar){
        final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL);
        channel.setMethodCallHandler(new LrcPlugin(registrar.activity()));
    }
    public LrcPlugin(Activity mActivity){
        this.mActivity=mActivity;
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        this.result=result;
        switch (methodCall.method){
            case "lrc"://歌词解析
                try {
                   String lrc=LyricAnalysis.getKrcText(methodCall.argument("lrc"),methodCall.argument("lrcName"));
                   Log.d(TAG,"tag-n debug lrc:"+lrc);
                   if(MediaPlayerTools.getInstance().onMediaPlayListener!=null){
                       MediaPlayerTools.getInstance().onMediaPlayListener.onReadLrc(lrc);
                   }
                }catch (Exception e){

                }
                break;


            default:
                break;
        }
    }
}
