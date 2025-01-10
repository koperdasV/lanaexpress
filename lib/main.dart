import 'dart:async';

import 'package:flutter/material.dart';
import 'package:l/l.dart';
import 'package:lanaexpress/background_service.dart';
import 'package:lanaexpress/initialization.dart';
import 'package:lanaexpress/app_core.dart';
import 'package:lanaexpress/utils/error_utils.dart';

void main() => runZonedGuarded<void>(
      () => l.capture<void>(
        () async {
          try {
            await $initializeApp();
            await initializeService();
          } on Object catch (error, stackTrace) {
            ErrorUtil.logError(error, stackTrace).ignore();
            runApp(const AppError());
            return;
          }
          runApp(const FurYardApp());
        },
        const LogOptions(
          handlePrint: true,
          outputInRelease: true,
          printColors: true,
        ),
      ),
      l.e,
    );
/// {@template app_error}
/// AppError widget
/// {@endtemplate}
final class AppError extends StatelessWidget {
  /// {@macro app_error}
  const AppError({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => const MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: Center(
              child: Text(
                'Something went wrong',
                textScaler: TextScaler.linear(2),
              ),
            ),
          ),
        ),
      );
}