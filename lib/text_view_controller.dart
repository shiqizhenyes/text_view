
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class TextViewController {


  TextViewController({@required this.id}) {
    _channel = MethodChannel("$_channelName"+ "_"+ "$id");
  }

  MethodChannel _channel;
  String _channelName = "plugin.nice.me/text_view";

  final int id;


  Future<void> setText(String text) {
    assert(text.isNotEmpty && text != null);
    return _channel.invokeMethod("setText", text);
  }


}