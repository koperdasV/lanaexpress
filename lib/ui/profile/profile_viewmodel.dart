import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lanaexpress/core/base/ui/base_controller.dart';
import 'package:lanaexpress/core/services/auth_service.dart';
import 'package:lanaexpress/data/managers/logger/log_manager.dart';
import 'package:lanaexpress/data/source/preference_manager.dart';
import 'package:lanaexpress/data/source/secure_storage_manager.dart';
import 'package:lanaexpress/generated/router.dart';
import 'package:lanaexpress/generated/router.gr.dart' as gr;

final class ProfileViewModel extends BaseController {
  late final AuthService _authService = AuthService.to;
  late final SecureStorageManager storageManager = SecureStorageManager();

  Future<void> logout(final BuildContext context) async {
    String token = '';
    try {
      token = await PreferenceManager().getAccessToken();
      await _authService.logout(token);
      await storageManager.deleteData('auth_token');
      await PreferenceManager().clearUserSpecificData();
      router.push(const gr.LoginView());
    } catch (e, stackTrace) {
      LogManager().log(e, stackTrace);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error during logout. Please try again later.'),
          ),
        );
      }
    }
  }

  List<File> imageFiles = <File>[];

  Future<void> openImagePicker(final bool isCamera) async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage;
    if (isCamera) {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedImage = await picker.pickImage(source: ImageSource.gallery);
    }
    // або ImageSource.camera

    if (pickedImage != null) {
      // Файл вибрано успішно, можна обробити його
      final File imageFile = File(pickedImage.path);
      imageFiles.add(imageFile);

      // Тут ви можете використовувати imageFile для подальшої обробки або завантаження
    } else {
      // Користувач скасував вибір фото
    }
    notifyListeners();
  }

  void deleteImages(final dynamic value) {
    imageFiles.remove(value);
    notifyListeners();
  }
}
