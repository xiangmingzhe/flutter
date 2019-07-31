package com.example.flutter_app.plugin;

import android.app.Activity;
import android.widget.CalendarView;
import android.widget.Toast;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * Time:2019/7/26
 * Author:xmz-dell
 * Description:
 */
public class ToastPlugin implements MethodChannel.MethodCallHandler{
    private Activity mActivity;
    private MethodChannel.Result result;
    public static String CHANNEL = "com.mrper.framework.plugins/toast"; // 分析1
    public static void registerWith(PluginRegistry.Registrar registrar){
        final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL);
        channel.setMethodCallHandler(new ToastPlugin(registrar.activity()));
    }
    public ToastPlugin(Activity mActivity){
            this.mActivity=mActivity;
    }
    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
            this.result=result;
            switch (methodCall.method){
                case "showall":
                    Toast.makeText(mActivity, methodCall.argument("msg"),Toast.LENGTH_SHORT).show();
                    break;
            }
    }
}
