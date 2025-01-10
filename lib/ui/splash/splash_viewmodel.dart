import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:lanaexpress/core/base/ui/base_controller.dart';
import 'package:lanaexpress/data/managers/logger/log_manager.dart';
import 'package:lanaexpress/data/source/preference_manager.dart';
import 'package:lanaexpress/generated/router.dart';
import 'package:lanaexpress/generated/router.gr.dart' as gr;
import 'package:lanaexpress/utils/utils.dart';

class SplashViewModel extends BaseController {
  final PreferenceManager _pref = PreferenceManager.singleton;
  final Connectivity _connectivity = Connectivity();

  Future<void> init() async {
    await futureDelayedFunc(milliseconds: 1300);
    _pref.getOnBoardingSeen();
    final ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
        initializeApp();
        break;
      case ConnectivityResult.mobile:
        initializeApp();
        break;
      default:
        //showWebColoredToast('textNoInternetConnection'.tr);
        break;
    }
  }

  Future<void> initializeApp() async {
    String token = '';
    try {
      token = await PreferenceManager().getAccessToken();
      if (token.isNotEmpty) {
        router.push(const gr.MainMobile());
      } else {
        router.push(const gr.LoginView());
      }
    } catch (e, stackTrace) {
      LogManager().log(e, stackTrace);
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
