//
//  FlutterTextView.swift
//  Pods-Runner
//
//  Created by Shiqizhen on 2020/6/24.
//

import Flutter
import UIKit
public class FlutterTextView: NSObject, FlutterPlatformView {
    
    let textView = UITextView()
    

    public func view() -> UIView {
        return textView
    }
    
    
    func setText(text: String) -> Void {
        textView.text = text
    }
    
    func setTextSize(textSize: CGFloat) -> Void {
        textView.font = UIFont.systemFont(ofSize: textSize)
    }
    
}
