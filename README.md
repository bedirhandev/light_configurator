# speech_to_text

A new Flutter project that enables to send PWM signals to an ESP with your voice or through a color picker. The app has a broad variety of colors on deck.

## Minor tweaks in order to let speech_recognition plugin work

1.  giving access to a directory
    warning: Insecure world writable dir .. in PATH, mode 040777
    sudo chmod -R o-w /Users/bedirhandincer/development/flutter/bin

## Podfile editing
1.  uncommend platform :ios, '9.0'
2.  target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
3.  target 'Runner' do
        use_frameworks!

## Last call
Go to the build settings and search for swift and edit the version to 4.0 instead of 5.0 (current version)
[If still things are not working, add a empty swift file without bridging inside the Runner directory]

## Works with the esp8266 wroom 02
By reading the log of the device you can see the IP where it is listening to.
Firstly, give the virtualbox access to the USB port with the following commando:
sudo chmod a+rw /dev/ttyUSB0 access read write to everyone
after that the following commando will output the output of ESP microchip through UART
RX/TX after debugging with make monitor the results of the IP is listed in the terminal
Like for example: IP 192.168.1.15, changes in the code has to made accordingly
Furthermore, the piece of code for the ESP device deals with a basic HTTP server, connection with the ESPTouch and writing the PWM signal to the IO pins