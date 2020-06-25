import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';


typedef void TextViewCreatedCallback(String result, int id);

class TextView extends StatefulWidget{

  TextView({Key key,@required this.text, this.textSize, this.createdCallback})
      : super(key: key);

  final String text;

  final double textSize;

  final TextViewCreatedCallback createdCallback;

  static String _viewType = "me.nice/text_view";

  static MethodChannel _channel = _channel = MethodChannel(_viewType);

  static Future<String> get platformVersion async {
    try {
      final String version = await _channel.invokeMethod('getPlatformVersion');
      return version;
    }catch (e) {
      return "unknown";
    }
  }

  @override
  _TextViewState createState() => _TextViewState();

}

class _TextViewState extends State<TextView> {

  @override
  void initState() {
    super.initState();
    TextView._channel.setMethodCallHandler((call) async {
      if(call.method == "platformViewCreated") {
        TextView._channel.invokeMethod("setText", widget.text);
        TextView._channel.invokeMethod("setTextSize", widget.textSize);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: TextView._viewType+"_${Platform.operatingSystem}",
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (Platform.isIOS){
      return UiKitView(
        viewType: TextView._viewType+"_${Platform.operatingSystem}",
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return Text("this plugin not support");
  }

  void _onPlatformViewCreated(int id) {
    if (widget.createdCallback == null) {
      return;
    }
    widget.createdCallback("success", id);
  }

}
