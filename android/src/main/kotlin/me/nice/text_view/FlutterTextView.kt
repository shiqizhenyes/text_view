package me.nice.text_view

import android.content.Context
import android.view.View
import android.widget.TextView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

class FlutterTextView(context: Context, messenger: BinaryMessenger, id: Int)
    : PlatformView, MethodChannel.MethodCallHandler{

    private val textView : TextView = TextView(context)

    private val methodChannel: MethodChannel = MethodChannel(messenger,"plugin.nice.me/text_view_$id")

    init {
        methodChannel.setMethodCallHandler(this)
    }

    override fun getView(): View {
        return textView
    }

    override fun dispose() {
    }

    private fun setText(text: String?) {
        textView.text = text
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "setText") {
            val text = call.arguments
            setText(text as String?)
            result.success(text)
        } else {
            result.notImplemented()
        }
    }
}