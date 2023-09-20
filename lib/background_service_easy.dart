import 'dart:async';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

class BackgroundService {
  /// define the function to run when set to foreground
  final Function()? onForeground;

  /// define the function to run when set to background
  final Function()? onBackground;

  /// define the function to run when stop method is called
  final Function()? onStop;

  BackgroundService({
    this.onStop,
    this.onForeground,
    this.onBackground,
  }) {
    _initializeService().then((value) => setToForeground());
  }

  static final FlutterBackgroundService _service = FlutterBackgroundService();

  static void setToForeground() {
    _service.invoke('setAsForeground');
  }

  static void setToBackground() {
    _service.invoke('setAsBackground');
  }

  static void stop() {
    _service.invoke('stopService');
  }

  Future<void> _initializeService() async {
    await _service.configure(
        iosConfiguration: IosConfiguration(
          onForeground: _onStart,
          autoStart: true,
          onBackground: _onIosBackground,
        ),
        androidConfiguration: AndroidConfiguration(
          onStart: _onStart,
          isForegroundMode: true,
          autoStart: true,
          autoStartOnBoot: true,
        ));
  }

  @pragma('vm:entry-point')
  Future<bool> _onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    return true;
  }

  @pragma('vm:entry-point')
  void _onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service
            .setAsForegroundService()
            .then((_) => onForeground == null ? (_) {} : onForeground!());
      });

      service.on('setAsBackground').listen((event) {
        service
            .setAsBackgroundService()
            .then(onBackground == null ? (_) {} : onBackground!());
      });

      service.on('stopService').listen((event) {
        service.stopSelf();
      });
    }
  }
}
