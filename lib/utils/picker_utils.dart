// import 'dart:io';

// import 'package:image_picker/image_picker.dart' as imp;
// import 'package:file_picker/file_picker.dart' as flp;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lanaexpress/data/managers/logger/log_manager.dart';
// import 'package:lanaexpress/utils/utils.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';

// class ImageDTO {
//   final PickedFile? file;

//   ImageDTO(
//     this.file,
//   );
// }

// class ImageMobileDTO {
//   final File? file;

//   ImageMobileDTO(
//     this.file,
//   );
// }

// class PickerUtils {
//   static final LogManager _logger = LogManager();

//   static Future<flp.FilePickerResult?> pickFile({
//     final bool allowMultiple = false,
//     final flp.FileType type = flp.FileType.any,
//     final List<String>? allowedExtensions,
//   }) async {
//     try {
//       if (await getPhotosPermission()) {
//         final flp.FilePickerResult? result = await flp.FilePicker.platform.pickFiles(
//           allowMultiple: allowMultiple,
//           withData: true,
//           type: type,
//           allowedExtensions: allowedExtensions,
//         );
//         return result;
//       } else {
//         return null;
//       }
//     } catch (e, s) {
//       _logger.log(e, s);
//       return null;
//     }
//   }

//   static Future<imp.XFile?> pickFromGallery() async {
//     try {
//       if (await getPhotosPermission()) {
//         return await imp.ImagePicker().pickImage(
//           source: imp.ImageSource.gallery,
//         );
//       } else {
//         return null;
//       }
//     } catch (e, s) {
//       _logger.log(e, s);
//       return null;
//     }
//   }

//   static Future<imp.XFile?> pickFromCamera() async {
//     try {
//       if (await getCameraPermission()) {
//         return await imp.ImagePicker().pickImage(
//           source: imp.ImageSource.camera,
//         );
//       } else {
//        showColoredToast('cameraAccessIsDenied');
//         return null;
//       }
//     } catch (e, s) {
//       _logger.log(e, s);
//       return null;
//     }
//   }

//   static Future<flp.FilePickerResult?> pickFileImage({
//     final bool allowMultiple = false,
//   }) async {
//     final flp.FilePickerResult? result = await pickFile(
//       allowMultiple: allowMultiple,
//       type: flp.FileType.custom,
//       allowedExtensions: ['png', 'jpg', 'jpeg'],
//     );
//     return result;
//   }

//   static Future<List<AssetEntity>?> multiPickImageMobile({
//     required final BuildContext context,
//     required final int currentLength,
//     final int maxLength = 10,
//     final List<AssetEntity>? selectedAssets,
//   }) async {
//     try {
//       if (await getPhotosPermission() && context.mounted) {
//         return await AssetPicker.pickAssets(
//           context,
//           pickerConfig: AssetPickerConfig(
//             selectedAssets: selectedAssets,
//             maxAssets: maxLength - currentLength,
//             //textDelegate: const PickerTextDelegate(),
//             specialPickerType: SpecialPickerType.noPreview,
//             //pickerTheme: pickerTheme,
//           ),
//         );
//       } else {
//         openAppSettings();
//       }
//     } catch (e, s) {
//       _logger.log(e, s);
//     }
//     return null;
//   }

//   static Future<bool> getPhotosPermission() async {
//     final PermissionStatus? permission = await getPhotosPermissionStatus();
//     return permission == null || permission.isGranted || permission.isLimited;
//   }

//   static Future<PermissionStatus?> getPhotosPermissionStatus() async {
   
//     // else if (await isOldAndroid()) {
//     //   return await Permission.storage.request();
//     // } 
//     if (Platform.isIOS) {
//       return await Permission.photosAddOnly.request();
//     } else {
//       return await Permission.photos.request();
//     }
//   }

//   static Future<bool> getCameraPermission() async {
   
//       return await Permission.camera.request().isGranted;
    
//   }
// }
