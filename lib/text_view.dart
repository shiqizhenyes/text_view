import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:text_view/text_view_controller.dart';


typedef void TextViewCreatedCallback(TextViewController controller);

class TextView extends StatefulWidget {

  static const MethodChannel _channel =
      const MethodChannel('text_view');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }


  TextView({Key key, this.createdCallback}) : super(key: key);

  final TextViewCreatedCallback createdCallback;

  @override
  _TextViewState createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {

  final _viewType = "me.nice/text_view";

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: _viewType,
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return Text("this plugin not support");
  }

  void _onPlatformViewCreated(int id) {
    print("view id $id");
    if (widget.createdCallback == null) {
      return;
    }
    widget.createdCallback(TextViewController(id: id));
  }


}
