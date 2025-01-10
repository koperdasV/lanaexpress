import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/core/base/ui/base_controller.dart';
import 'package:lanaexpress/core/http_client/dio_client.dart';
import 'package:lanaexpress/core/services/auth_service.dart';
import 'package:lanaexpress/data/managers/logger/log_manager.dart';
import 'package:lanaexpress/data/source/preference_manager.dart';
import 'package:lanaexpress/data/source/secure_storage_manager.dart';
import 'package:lanaexpress/domain/responses/auth_response.dart';
import 'package:lanaexpress/generated/router.dart';
import 'package:lanaexpress/generated/router.gr.dart' as gr;
import 'package:lanaexpress/utils/utils.dart';

final class LoginViewModel extends BaseController {
  late final AuthService authService = AuthService.to;
  late final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
  late final SecureStorageManager storageManager = SecureStorageManager();

  double animatedLogoWidth = 0;
  final double buttonsHeight = 48;
  final double buttonsWidth = 320;

  AuthResponse? _authResponse;

  AuthResponse? get authResponse => _authResponse;

  set authResponse(final AuthResponse? authResponse) {
    _authResponse = authResponse;
    notifyListeners();
  }

  String? emailValidator(final String? value) {
    if (emailController.text.isEmpty) {
      return 'The field must not be empty';
    } else if (!emailController.text.isPhoneNumber && !emailController.text.isEmail) {
      return 'Invalid email format';
    }
    return null;
  }

  Future<void> init() async {}

  Future<void> login(final String email, final String password) async {
    const String apiUrl = 'https://tms.lana.express/api/v1/login';

    if (email.isNotEmpty) {
      if (password.isNotEmpty) {
        try {
          final Response<dynamic> response =
              await DioClient.instance.processPost(
            apiUrl,
            data: jsonEncode(
              <String, String>{'email': email, 'password': password},
            ),
            options: Options(
              headers: <String, String>{'Content-Type': 'application/json'},
            ),
          );

          if (response.statusCode == 200) {
            final Map<String, dynamic> data = response.data;
            final String token = data['token'];
            await Future.wait(<Future<bool>>[
              PreferenceManager().setAccessToken(token),
            ]);
            await storageManager.writeData('auth_token',token);
            final bool isOnBoardingSeen =
                await PreferenceManager().getOnBoardingSeen();

            if (isOnBoardingSeen) {
              router.push(const gr.MainMobile());
            } else {
              router.push(
                const gr.OnBoardingScreen(),
              );
            }
          } else {
            final Map<String, dynamic> error = response.data;
            toastCheck(
              'Authorization error: ${error['error']}',
              backgroundColor: red,
            );
          }
          if (response.statusCode == 400) {
            toastCheck(
              'Authorization error: ',
              backgroundColor: red,
            );
          }
        } catch (e, stackTrace) {
          LogManager().log(e, stackTrace);
          toastCheck('Invalid credential', backgroundColor: red);
        }
      } else {
        toastCheck('Please enter your password');
      }
    } else {
      toastCheck('Please enter your email');
    }
  }
}
