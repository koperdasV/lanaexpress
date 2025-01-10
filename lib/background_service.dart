import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lanaexpress/data/source/secure_storage_manager.dart';

import 'package:lanaexpress/data/managers/logger/log_manager.dart';
import 'package:lanaexpress/utils/utils.dart';

Future<void> initializeService() async {
  final FlutterBackgroundService service = FlutterBackgroundService();
  bool serviceEnabled;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await Geolocator.openLocationSettings();
    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.openLocationSettings();
    }
  }

  ///isForegroundMode: false : The background mode requires running in 
  ///release mode and requires disabling battery optimization so that the service 
  ///stays up when the user closes the application.
  ///
  ///isForegroundMode: true : Displays a silent notification when used 
  ///according to Android's Policy
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

@pragma('vm:entry-point')
bool onIosBackground(
  final ServiceInstance service,
) {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(final ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  late final SecureStorageManager storageManager = SecureStorageManager();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((final Map<String, dynamic>? event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((final Map<String, dynamic>? event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((final Map<String, dynamic>? event) {
    service.stopSelf();
  });

  // bring to foreground
  Timer.periodic(const Duration(seconds: 15), (final Timer timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
          title: "My App Service",
          content: "Updated at ${DateTime.now()}",
        );
      }
    }
    Future<bool> checkIfAuthenticated() async {
      final String? token = await storageManager.readData('auth_token');
      return token != null && token.isNotEmpty;
    }

    /// you can see this log in logcat
    debugPrint('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
    late LocationSettings locationSettings;

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 10),
          //(Optional) Set foreground notification config to keep the app alive
          //when going to the background
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText:
                "Example app will continue to receive your location even when you aren't using it",
            notificationTitle: "Running in Background",
            enableWakeLock: true,
          ),);
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.other,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: false,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: false,
      );
    }
    final Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
    final bool isAuthenticated = await checkIfAuthenticated();
    if (isAuthenticated) {
      final bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnabled) {
        sendLocationToServer(storageManager, position);
      }
    }

    service.invoke(
      'update',
      <String, dynamic>{
        "current_date": DateTime.now().toIso8601String(),
        "position": position,
      },
    );
  });
}

@pragma('vm:entry-point')
void sendLocationToServer(
  final SecureStorageManager storageManager,
  final Position position,
) async {
  final String? token = await storageManager.readData('auth_token');
  final Map<String, String> headers = <String, String>{
    "Authorization": "Bearer $token",
  };
  try {
    final Dio dio = Dio();
    final Response<dynamic> response = await dio.post(
      "https://tms.lana.express/api/v1/driver-tracking",
      options: Options(headers: headers, preserveHeaderCase: true),
      data: <String, double>{
        'lat': position.latitude,
        'lng': position.longitude,
      },
    );

    if (response.statusCode == 200) {
      //toastCheck('${position.latitude}, ${position.longitude}');
    } else {
      debugPrint(response.statusMessage);
    }
  } catch (e, stackTrace) {
    LogManager().log(e, stackTrace);
  }
}
