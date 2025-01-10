import 'package:lanaexpress/data/managers/logger/log_manager.dart';

class ErrorsManager {
  ErrorsManager._internal();

  static ErrorsManager? _instance;

  factory ErrorsManager() {
    _instance ??= ErrorsManager._internal();
    return _instance!;  
  }

  Future<void> workWithError(dynamic error, StackTrace? stackTrace) async {
    await LogManager().log(error, stackTrace);
    //showWebColoredToast(await _handleMessage(error));
  }

  // Future<String> _handleMessage(final dynamic error) async {
  //   if (error is CommonApiError) {
  //     final String errorMessage =
  //         ApiErrors.errorMessage(error.id, handleDefault: false);
  //     if (errorMessage.isNotEmpty) {
  //       return errorMessage;
  //     }
  //     if (error.message != null) {
  //       try {
  //         final GoogleTranslator translator = GoogleTranslator();
  //         final Translation translation = await translator.translate(
  //             error.toString(),
  //             from: 'en',
  //             to: '${Get.deviceLocale?.languageCode}');
  //         return translation.text;
  //       } catch (e) {
  //         return (error.message ?? error.id ?? '')
  //             .tr;
  //       }
  //     }
  //     return (error.message ?? error.id ?? '').tr;
  //   }
  //   return error.toString();
  // }
}
