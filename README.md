# speech_to_text

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Minor tweaks has to be made for speech_recognition plugin

1.  giving access to a directory
    warning: Insecure world writable dir .. in PATH, mode 040777
    sudo chmod -R o-w /Users/bedirhandincer/development/flutter/bin

# Editing the podfile
1.  uncommend platform :ios, '9.0'
2.  target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
3.  target 'Runner' do
        use_frameworks!

# If there are still problems
Go to the build settings and search for swift and edit the version to 4.0 instead of 5.0 (current version)
[If still things are not working, add a empty swift file without bridging inside the Runner directory]

# Works with the esp8266 wroom 02