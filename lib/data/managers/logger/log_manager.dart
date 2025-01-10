import 'package:logger/logger.dart';

class LogManager {
  // LogManager._internal();

  // static LogManager? _instance;

  // factory LogManager() {
  //   _instance ??= LogManager._internal();
  //   return _instance!;
  // }

  final Logger _logger = Logger();

  // void debugPrint(String message) {
  //   if (f.kDebugMode) {
  //     f.debugPrint("||---- $message");
  //   }
  // }

  Future<void> log(dynamic err, [StackTrace? stackTrace]) async {
    if (err is Exception) {
      _logger.e(err.toString(), error: err, stackTrace: stackTrace);
    } else if (err is Error) {
      _logger.e(err.toString(), error: err, stackTrace: err.stackTrace);
    } else {
      _logger.e(err);
    }
    //await _notifyCrashlytics(err, stackTrace);
  }

  // Future<void> _notifyCrashlytics(dynamic err, StackTrace? stackTrace) async {
  //   if (!f.kReleaseMode) {
  //     return;
  //   }
  //   if (f.kIsWeb) {
  //     return;
  //   }
  //   if (isInternetException(err)) {
  //     return;
  //   }
  //   await FirebaseCrashlytics.instance.recordError(err, stackTrace);
  // }
}
