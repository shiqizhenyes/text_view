package me.nice.text_view_example

import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
//import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
import me.nice.text_view.TextViewPlugin

/**
 * io.flutter.app.FlutterActivity
 * io.flutter.embedding.android.FlutterActivity
 *
 * pre-Flutter-1.12 Android projects. 使用app.FlutterActivity  手动注册
 * Flutter-1.12 以后，使用embedding.android.FlutterActivity 半自动注册
 *
 */
class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        flutterEngine?.let {
            GeneratedPluginRegistrant.registerWith(it)
        }
        Log.d("MainActivity", "启动了 ")
    }
}
