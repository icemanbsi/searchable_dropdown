#import "SearchChoicesForPushPlugin.h"
#if __has_include(<search_choices_for_push/search_choices_for_push-Swift.h>)
#import <search_choices_for_push/search_choices_for_push-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "search_choices_for_push-Swift.h"
#endif

@implementation SearchChoicesForPushPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSearchChoicesForPushPlugin registerWithRegistrar:registrar];
}
@end
