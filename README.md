# Introduction

A Flutter package for managing background services in your Flutter applications.


## Getting Started

To use this package, add `background_service_easy` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  background_service_easy: ^1.0.0
```


# Configuration

* This package provides different configurations for iOS and Android using the `flutter_background_service` and `flutter_background_service_android` packages.

* For iOS, you can configure it using the `IosConfiguration` class, and for Android, you can configure it using the `AndroidConfiguration` class.


## iOS

* Enable background_fetch capability in xcode (optional), if you wish ios to execute IosConfiguration.onBackground callback.

* For iOS 13 and Later (using BGTaskScheduler), insert lines below into your ios/Runner/Info.plist

```plist
<key>BGTaskSchedulerPermittedIdentifiers</key>
<array>
    <string>dev.flutter.background.refresh</string>
</array>
```

* You can also using your own custom identifier In ios/Runner/AppDelegate.swift add line below
```swift
import UIKit
import Flutter
import flutter_background_service_ios // add this

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    /// Add this line
    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "your.custom.task.identifier"

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```


## Usage

```dart
import 'package:background_service_easy/background_service_easy.dart';

void main() {
    // the constructor automatically set to foreground when initialized
  BackgroundService( 
    onForeground: () {
      // Callback when the service is set to the foreground.
    },
    onBackground: () {
      // Callback when the service is set to the background or app is closed.
    },
    onStop: () {
      // Callback when the service is stopped.
    },
  );
}

void setToBackground() {
  BackgroundService.setToBackground(); // default. call only when it is set to background
}

void setToBackground() {
  BackgroundService.setToBackground(); // call this on dispose
}

void stop() {
  BackgroundService.stop(); // call this method to stop running service
}
```

### Functions
* `setToForeground()`: Set the service to the foreground.
* `setToBackground()`: Set the service to the background.
* `stop()`: Stop the service.


## Example
For a complete example of how to use this package, please refer to the example directory.

## License
This package is released under the MIT [License](LICENSE).

## Contribution
Contributions are Welcome, don't foreget to create a [pull request](https://www.github.com/mryadavdilip/background_service_easy/pulls).

## Author
Dilip Yadav. Connect with me on [Linkedin](https://www.linkedin.com/in/mryadavdilip)