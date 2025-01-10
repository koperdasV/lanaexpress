import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lanaexpress/core/http_client/common_error_models.dart';
import 'package:lanaexpress/core/http_client/token_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retry/retry.dart';

class DioClient {

  DioClient._();
  static const int _sendTimeoutMillis = 30000;
  static const int _receiveTimeoutMillis = 300000;
  static String urlBase = "";

  static final DioClient _instance = DioClient._();

  static DioClient get instance => _instance;

  final Connectivity _connectivity = Connectivity();

  static const int _defaultMaxAttemptsCount = 3;

  static BaseOptions _getBaseOptions() {
    return BaseOptions(
      baseUrl: urlBase,
      // connectTimeout: 20000,
      sendTimeout: const Duration(milliseconds: _sendTimeoutMillis),
      receiveTimeout: const Duration(milliseconds: _receiveTimeoutMillis),
      preserveHeaderCase: true,
    );
  }

  final Dio _dio = Dio(_getBaseOptions());

  static void configure() {
    _instance._dio.interceptors.add(TokenInterceptor());
    if (kDebugMode) {
      _instance._dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      );
    }
  }

  static const List<int> _retryStatusCodes = <int>[
    _HttpStatus.notFound,
    _HttpStatus.forbidden,
    // _HttpStatus.unsupportedMediaType,
    _HttpStatus.badRequest,
  ];

  static const List<int> _defaultUndefinedErrorCodes = <int>[
    _HttpStatus.internalServerError,
    _HttpStatus.notImplemented,
    _HttpStatus.badGateway,
    _HttpStatus.serviceUnavailable,
  ];

  Future<Response<dynamic>> processGet(
    final String path, {
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onReceiveProgress,
  }) async {
    final ConnectivityResult resultConnectivity = await _connectivity.checkConnectivity();
    if (resultConnectivity == ConnectivityResult.none) {
      throw CommonErrorNoNetwork();
    }
    try {
      final Response<dynamic> resp = await retry<Response<dynamic>>(
        () async {
          return _dio.get(path,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onReceiveProgress: onReceiveProgress,);
        },
        maxAttempts: _defaultMaxAttemptsCount,
        retryIf: (final Exception exception) => _retryPolicy(
          exception: exception,
          retryStatusCodes: _retryStatusCodes,
        ),
      );
      return resp;
    } on DioException catch (e) {
      final CommonError processedError = await _processDioError(e);
      if (processedError is CommonErrorUnauthorized) {
       // AuthService.to.logOut();
        throw processedError;
      }
      throw processedError;
    } on Object catch (e, stackTrace) {
      throw Error.throwWithStackTrace(e, stackTrace);
    }
  }

  Future<Response<dynamic>> processPost(
    final String path, {
    final dynamic data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onSendProgress,
    final ProgressCallback? onReceiveProgress,
  }) async {
    final ConnectivityResult resultConnectivity = await _connectivity.checkConnectivity();
    if (resultConnectivity == ConnectivityResult.none) {
      throw CommonErrorNoNetwork();
    }
    try {
      final Response<dynamic> resp = await retry<Response<dynamic>>(
        () async {
          return _dio.post(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
        },
        maxAttempts: _defaultMaxAttemptsCount,
        retryIf: (final Exception exception) => _retryPolicy(
          exception: exception,
          retryStatusCodes: _retryStatusCodes,
        ),
      );
      return resp;
    } on DioException catch (e) {
      final CommonError processedError = await _processDioError(e);
      if (processedError is CommonErrorUnauthorized) {
        //AuthService.to.logOut();
        // router.removeUntil((route) => route.name == LoginView.name);
        throw processedError;
      }
      throw processedError;
    } on Object catch (e, stackTrace) {
      throw Error.throwWithStackTrace(e, stackTrace);
    }
  }
  Future<Response<dynamic>> processDelete(
    final String path, {
    final dynamic data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
  }) async {
    final ConnectivityResult resultConnectivity = await _connectivity.checkConnectivity();
    if (resultConnectivity == ConnectivityResult.none) {
      throw CommonErrorNoNetwork();
    }
    try {
      final Response<dynamic> resp = await retry<Response<dynamic>>(
        () async {
          return _dio.delete(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
          );
        },
        maxAttempts: _defaultMaxAttemptsCount,
        retryIf: (final Exception exception) => _retryPolicy(
          exception: exception,
          retryStatusCodes: _retryStatusCodes,
        ),
      );
      return resp;
    } on DioException catch (e) {
      final CommonError processedError = await _processDioError(e);
      if (processedError is CommonErrorUnauthorized) {
        //AuthService.to.logOut();
        // router.removeUntil((route) => route.name == LoginView.name);
        throw processedError;
      }
      throw processedError;
    } on Object catch (e, stackTrace) {
      throw Error.throwWithStackTrace(e, stackTrace);
    }
  }

  Future<CommonError> _processDioError(final DioException dioError) async {
    final dynamic responseData = dioError.response?.data;
    final int? statusCode = dioError.response?.statusCode;

    if (dioError.type == DioExceptionType.connectionTimeout ||
        dioError.type == DioExceptionType.sendTimeout ||
        statusCode == _HttpStatus.networkConnectTimeoutError) {
      return CommonErrorNoNetwork();
    }

    if (statusCode == _HttpStatus.unauthorized) {
      return CommonErrorUnauthorized(dioError.error.toString());
    }

    if (statusCode == _HttpStatus.tooManyRequests) {
      return CommonErrorToManyRequests();
    }

    if (statusCode == _HttpStatus.internalServerError ||
        statusCode == _HttpStatus.badGateway ||
        statusCode == _HttpStatus.notImplemented ||
        statusCode == _HttpStatus.gatewayTimeout ||
        statusCode == _HttpStatus.httpVersionNotSupported) {
      final CommonApiError error = CommonApiError.fromJson(responseData['errors']);
      return CommonApiError(error.id, error.message,
          statusCode: statusCode.toString(),);
    }

    if (_defaultUndefinedErrorCodes.contains(statusCode)) {
      return CommonErrorUndefined(dioError.message.toString());
    }

    Object? errorJson;
    if (responseData is String) {
      //В случае если ожидался Response<String> dio не будет парсить возвращенную json-ошибку
      //и нам это нужно сделать вручную
      try {
        errorJson = jsonDecode(responseData);
      } on FormatException {
        return CommonFormatException(responseData);
        //Возможно был нарушен контракт/с сервером случилась беда, тогда мы вернем [CommonResponseError.undefinedError]
        // ('Получили ответ: \n "$responseData" \n что не является JSON');
      }
    } else if (responseData is Map<String, dynamic>) {
      //Если запрос ожидал JSON, то и json-ответ ошибки будет приведен к нужному виду
      errorJson = responseData;
    }

    if (errorJson is Map<String, dynamic> && errorJson['errors'] != null) {
      try {
        final CommonApiError apiError = CommonApiError.fromJson(errorJson['errors']);
        return apiError;
      } on TypeError catch (e) {
        return CommonTypeError(e, responseData);
      }
    }

    return CommonErrorUndefined(dioError.message.toString());
  }

  FutureOr<bool> _retryPolicy({
    required final Exception exception,
    required final List<int> retryStatusCodes,
  }) {
    if (exception is! DioException) {
      return false;
    }
    if (exception.type == DioExceptionType.cancel) {
      return false;
    }
    final Response<dynamic>? response = exception.response;
    if (response == null) {
      return true;
    }

    return retryStatusCodes.contains(response.statusCode);
  }
}

abstract class _HttpStatus {
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;

  // static const int unsupportedMediaType = 415;
  static const int internalServerError = 500;
  static const int notImplemented = 501;
  static const int badGateway = 502;
  static const int serviceUnavailable = 503;
  static const int gatewayTimeout = 504;
  static const int httpVersionNotSupported = 505;
  static const int networkConnectTimeoutError = 599;
  static const int tooManyRequests = 429;
}
