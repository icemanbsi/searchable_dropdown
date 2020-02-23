#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint search_choices.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'search_choices'
  s.version          = '0.0.1'
  s.summary          = 'Widget to let the user search through a string typed on a customizable keyboard in a single or multiple choices list presented as a dropdown'
  s.description      = <<-DESC
Widget to let the user search through a string typed on a customizable keyboard in a single or multiple choices list presented as a dropdown
                       DESC
  s.homepage         = 'https://github.com/lcuis/search_choices'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'jod.li' => 'flutter@jod.li' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
