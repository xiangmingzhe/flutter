package com.example.flutter_app;

import android.app.Activity;
import android.os.Bundle;

import com.example.flutter_app.lrc.LyricAnalysis;
import com.example.flutter_app.plugin.LrcPlugin;
import com.example.flutter_app.plugin.MusicPlayPlugin;
import com.example.flutter_app.plugin.SendMessagePlugin;
import com.example.flutter_app.plugin.ToastPlugin;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    registerCustomPlugin(this);
  }

  /**
   * 注册自定义plugin
   * @param registrar
   */
  private void registerCustomPlugin(PluginRegistry registrar) {
    ToastPlugin.registerWith(registrar.registrarFor(ToastPlugin.CHANNEL));
    MusicPlayPlugin.registerWith(registrar.registrarFor(MusicPlayPlugin.CHANNEL));
    SendMessagePlugin.registerWith(registrar.registrarFor(SendMessagePlugin.CHANNEL));
    LrcPlugin.registerWith(registrar.registrarFor(LrcPlugin.CHANNEL));
  }

}
