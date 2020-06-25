package me.nice.text_view

import android.os.Build
import android.util.Log
import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** TextViewPlugin */
public class TextViewPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var textView: FlutterTextView
    private val platform = "android"

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channelName = "me.nice/text_view"
        val viewTypeId = channelName + "_$platform"
        val textViewFactory = TextViewFactory(null, object : TextViewCreatedCallback {
            override fun created(id : Int, flutterTextView: FlutterTextView) {
                textView = flutterTextView
                channel = MethodChannel(flutterPluginBinding.binaryMessenger, channelName)
                channel.setMethodCallHandler(this@TextViewPlugin)
                channel.invokeMethod("platformViewCreated", "")
                Log.d("native android", textView.getHashcode().toString())
            }
        })
        val registrar = flutterPluginBinding.platformViewRegistry
                .registerViewFactory(viewTypeId, textViewFactory)
        Log.d("native android", "viewType $viewTypeId   $registrar")
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
//  companion object {
//    @JvmStatic
//    fun registerWith(registrar: Registrar) {
//      registrar
//              .platformViewRegistry()
//              .registerViewFactory("me.nice/text_view",
//                      TextViewFactory(registrar.messenger(), null));
//    }
//  }

    private fun getPlatformVersion(): String {
        return platform + " " + Build.VERSION.SDK_INT
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        Log.d("native android ", call.method + "   " + call.arguments  + " ")
        when (call.method) {
            "getPlatformVersion" -> {
                result.success(getPlatformVersion())
            }
            "setText" -> {
                val text = call.arguments
                textView.setText(text as String?)
                result.success(text)
            }
            "setTextSize" -> {
                textView.setTextSize((call.arguments as Double).toFloat())
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        textView.dispose()
    }
}
