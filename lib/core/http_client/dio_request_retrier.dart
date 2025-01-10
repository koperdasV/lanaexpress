import 'dart:async';

import 'package:dio/dio.dart';

class DioRequestRetrier {
  final Dio dio;

  DioRequestRetrier({
    required this.dio,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    final responseCompleter = Completer<Response>();

    responseCompleter.complete(
      dio.fetch(requestOptions),
    );
    return responseCompleter.future;
  }
}
