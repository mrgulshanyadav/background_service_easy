# Example

This example demonstrates how to use the `background_service_easy` package to manage background services in your Flutter application.

```dart
import 'package:flutter/material.dart';
import 'package:background_service_easy/background_service_easy.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // Initialize the background service, no need to set to foreground after initialization
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

  @override
  void dispose() {
    super.dispose();
    BackgroundService.setToBackground();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Background Service Example'),
      ),
      body: Center(
        child: Text('Background Service Example'),
      ),
    );
  }
}
```