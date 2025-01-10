import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:lanaexpress/core/http_client/dio_client.dart';
import 'package:lanaexpress/data/managers/logger/log_manager.dart';
import 'package:lanaexpress/domain/models/driver_tracking.dart';

class AuthService {
  static AuthService get to => Get.put(AuthService());

  Future<bool> login(final String email, final String password) async {
    return DioClient.instance.processPost(
      'https://tms.lana.express/api/v1/login',
      data: <String, String>{
        'email': email,
        'password': password,
      },
    ).then((final response) {
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    });
  }

  Future<void> logout(final String token) async {
    return DioClient.instance.processPost(
      'https://tms.lana.express/api/v1/logout',
      queryParameters: <String, dynamic>{'token': token},
    ).then((final response) {
      try {
        if (response.statusCode == 200) {
          if (kDebugMode) {
            print('Logout successful');
          }
        } else {
          if (kDebugMode) {
            print('Error during logout: ${response.statusCode}');
          }
        }
      } catch (e) {
        LogManager().log(e.toString());
      }
      return response.data['data'];
    });
  }

  Future<DriverTracking> sendLocationToServer(
    final double latitude,
    final double longitude,
  ) async {
    return DioClient.instance.processPost(
      "https://tms.lana.express/api/v1/driver-tracking",
      data: <String, double>{
        'lat': latitude,
        'lng': longitude,
      },
    ).then((response) => DriverTracking.fromJson(response.data['data']));
  }
}
