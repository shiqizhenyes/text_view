//
//  FlutterTextViewFactory.swift
//  Pods-Runner
//
//  Created by Shiqizhen on 2020/6/24.
//

import Flutter

protocol FlutterTextViewCreatedDelegate {
    func created(registrar: FlutterPluginRegistrar, id: Int64, textView: FlutterTextView)
}

public class FlutterTextViewFactory : NSObject, FlutterPlatformViewFactory {
    
    
    init(registrar: FlutterPluginRegistrar, createdDelegate: FlutterTextViewCreatedDelegate) {
        self.registrar = registrar
        delegate = createdDelegate
    
    }
    
    func FlutterTextViewFactory(createdDelegate: FlutterTextViewCreatedDelegate) {
        delegate = createdDelegate
    }
    
    var flutterTextView : FlutterTextView?
    
    var delegate : FlutterTextViewCreatedDelegate?
    
    var registrar: FlutterPluginRegistrar?
    
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        flutterTextView = FlutterTextView()
        if (delegate != nil) {
            delegate?.created(registrar: self.registrar!, id: viewId, textView: flutterTextView!)
        }
        return flutterTextView!
    }
    
}
