import 'package:dio/dio.dart';
import 'package:lanaexpress/data/source/preference_manager.dart';

class TokenInterceptor extends Interceptor {
  final _pref = PreferenceManager.singleton;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String accessToken = await _pref.getAccessToken();
    if (accessToken.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $accessToken";
      options.headers['Access-Control-Allow-Origin'] = '*';
    }

    return super.onRequest(options, handler);
  }
}
