import 'package:flutter/material.dart';
import 'package:lanaexpress/data/managers/error_manager/error_manager.dart';
import 'package:stacked/stacked.dart';

abstract class BaseController extends BaseViewModel {
  @protected
  void runWithErrorHandling(final Function() function) async {
    try {
      await function();
    } catch (error, stackTrace) {
      ErrorsManager().workWithError(error, stackTrace);
    }
  }

  @protected
  Future<void> handleError(final dynamic error, final StackTrace? stackTrace) async {
    await ErrorsManager().workWithError(error, stackTrace);
  }
}
