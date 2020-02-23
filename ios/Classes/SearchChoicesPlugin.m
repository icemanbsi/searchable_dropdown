#import "SearchChoicesPlugin.h"
#if __has_include(<search_choices/search_choices-Swift.h>)
#import <search_choices/search_choices-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "search_choices-Swift.h"
#endif

@implementation SearchChoicesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSearchChoicesPlugin registerWithRegistrar:registrar];
}
@end
