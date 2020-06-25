package me.nice.text_view

import android.content.Context
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class TextViewFactory(createArgsCodec: MessageCodec<Any>?,
                      callback: TextViewCreatedCallback) : PlatformViewFactory(createArgsCodec) {

    private var callback: TextViewCreatedCallback = callback
    private lateinit var flutterTextView : FlutterTextView
    var viewId: Int = 0
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        this.viewId = viewId
        flutterTextView = FlutterTextView(context, viewId)
        callback.created(viewId, flutterTextView)
        Log.d("native android", "viewId  $viewId")
        return flutterTextView
    }
    
}