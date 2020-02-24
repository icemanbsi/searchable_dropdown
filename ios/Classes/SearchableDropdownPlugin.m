#import "SearchableDropdownPlugin.h"
#if __has_include(<searchable_dropdown/searchable_dropdown-Swift.h>)
#import <searchable_dropdown/searchable_dropdown-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "searchable_dropdown-Swift.h"
#endif

@implementation SearchableDropdownPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSearchableDropdownPlugin registerWithRegistrar:registrar];
}
@end
