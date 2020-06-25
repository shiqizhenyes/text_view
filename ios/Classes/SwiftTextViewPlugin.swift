import Flutter
import UIKit

public class SwiftTextViewPlugin: NSObject, FlutterPlugin, FlutterTextViewCreatedDelegate {
    
    let platform = "ios"
    let channelName = "me.nice/text_view"
    var channele : FlutterMethodChannel?
    static var createdDelegate : FlutterTextViewCreatedDelegate?
    
    static var instents : SwiftTextViewPlugin?
    
    public override init() {
        super.init()
        print("init")
    }
    
    func initDelegate() -> Void{
        SwiftTextViewPlugin.createdDelegate = self
        print("initDelegate")
    }
    
    func created(registrar: FlutterPluginRegistrar, id: Int64, textView: FlutterTextView) {
        channele = FlutterMethodChannel(name: channelName,
                                          binaryMessenger: registrar.messenger())
          let instance = SwiftTextViewPlugin()
          registrar.addMethodCallDelegate(instance, channel: channele!)
          channele?.setMethodCallHandler { (call, result) in
            print(call.method)
              if (call.method == "getPlatformVersion") {
                  result(self.getPlatformVersion())
              } else if (call.method == "setText") {
                  textView.setText(text: call.arguments as! String)
              } else if (call.method == "setTextSize" ) {
                  textView.setTextSize(textSize: CGFloat(call.arguments as! Double))
              } else {
                  result(FlutterMethodNotImplemented)
              }
          }
         channele?.invokeMethod("platformViewCreated", arguments: "")
        
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    SwiftTextViewPlugin.init().initDelegate()
    let flutterTextViewFactory = FlutterTextViewFactory(
        registrar: registrar, createdDelegate: createdDelegate!)
    let viewTypeId = "me.nice/text_view_ios"
    registrar.register(flutterTextViewFactory, withId: viewTypeId)
  }

    func getPlatformVersion() -> String {
        return platform + " " + UIDevice.current.systemVersion
    }
    
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
    
    
}
