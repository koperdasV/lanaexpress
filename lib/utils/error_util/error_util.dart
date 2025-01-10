import 'dart:async';

import 'package:dio/dio.dart';
import 'package:http/src/exception.dart';

bool isInternetException(dynamic err) {
  return err is TimeoutException ||
      err is ClientException ||
      (err is DioException &&
          (err.type == DioExceptionType.receiveTimeout ||
              err.type == DioExceptionType.sendTimeout ||
              err.type == DioExceptionType.connectionTimeout ||
              isInternetException(err.error)));
}
