import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lanaexpress/core/base/dependency_injection.dart';
import 'package:lanaexpress/generated/locator.dart';
import 'package:lanaexpress/utils/custom_http_ovverides.dart';
import 'package:lanaexpress/utils/error_utils.dart';

Future<void>? _$initializeApp;

FutureOr<void> $initializeApp({
  final Future<void> Function()? onSuccess,
  final Future<void> Function(Object error, StackTrace stackTrace)? onError,
}) =>
    _$initializeApp ??= Future<void>(() async {
      late final WidgetsBinding binding;
      final Stopwatch stopwatch = Stopwatch()..start();
      try {
        binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();
        {
          await SystemChrome.setPreferredOrientations(
            <DeviceOrientation>[DeviceOrientation.portraitUp],
          );
          HttpOverrides.global = CustomHttpOverrides();
          setupLocator();
          InjectorDI();
        }
      } on Object catch (error, stackTrace) {
        onError?.call(error, stackTrace).ignore();
        ErrorUtil.logError(error, stackTrace, hint: 'Failed to initialize app')
            .ignore();
        rethrow;
      } finally {
        stopwatch.stop();
        onSuccess?.call().ignore();
        binding.addPostFrameCallback((final _) {
          // Closes splash screen, and show the app layout.
          binding.allowFirstFrame();
          //final context = binding.renderViewElement;
        });
      }
    });

@visibleForTesting
Future<void> $disposeApp() async {}
