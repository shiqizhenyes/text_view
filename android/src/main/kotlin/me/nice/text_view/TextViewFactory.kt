package me.nice.text_view

import android.content.Context
import io.flutter.embedding.android.FlutterTextureView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class TextViewFactory(private val messenger: BinaryMessenger, createArgsCodec: MessageCodec<Any>?)
    : PlatformViewFactory(createArgsCodec) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return FlutterTextView(context, messenger , viewId)
    }
}