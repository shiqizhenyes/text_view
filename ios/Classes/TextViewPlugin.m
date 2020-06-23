#import "TextViewPlugin.h"
#if __has_include(<text_view/text_view-Swift.h>)
#import <text_view/text_view-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "text_view-Swift.h"
#endif

@implementation TextViewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTextViewPlugin registerWithRegistrar:registrar];
}
@end
