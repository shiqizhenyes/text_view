package me.nice.text_view

import android.content.Context
import android.view.View
import android.widget.TextView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

class FlutterTextView(context: Context, id: Int) : PlatformView{

    private var textView : TextView? = TextView(context)

    override fun getView(): TextView? {
        return textView
    }

    override fun dispose() {
        textView = null
    }

    fun getHashcode(): Int {
        return hashCode()
    }

    fun setText(text: String?) {
        textView?.text = text
    }

    fun setTextSize(textSize: Float) {
        textView?.textSize = textSize
    }
}