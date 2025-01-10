import 'package:flutter/foundation.dart';
import 'package:lanaexpress/data/managers/permission_manager/permission_type.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestPermissionManager {

  /// Check a [permission] and return a [Future] with the result
  RequestPermissionManager(final PermissionType permissionType) {
    _permissionType = permissionType;
  }
  /// Permission type to request permission from user
  PermissionType? _permissionType;

  /// callback when permission is denied by user
  Function()? _onPermissionDenied;

  /// callback when permission is granted by user
  Function()? _onPermissionGranted;

  /// callback when permission is permanently denied by user
  Function()? _onPermissionPermanentlyDenied;

  Function()? _onPermissionAlwaysGranted;

  /// Request a [permission] , onPermissionDenied method to handle when permission is denied
  RequestPermissionManager onPermissionDenied(
      final Function()? onPermissionDenied,) {
    _onPermissionDenied = onPermissionDenied;
    return this;
  }

  ///  Request a [permission] ,onPermissionGranted method to handle when permission is granted
  RequestPermissionManager onPermissionGranted(
    final Function()? onPermissionGranted,
  ) {
    _onPermissionGranted = onPermissionGranted;

    return this;
  }

  ///  Request a [permission] ,onPermissionPermanentlyDenied method to handle when permission is permanently denied
  RequestPermissionManager onPermissionPermanentlyDenied(
    final Function()? onPermissionPermanentlyDenied,
  ) {
    _onPermissionPermanentlyDenied = onPermissionPermanentlyDenied;

    return this;
  }

  // Функція для обробки випадку, коли дозвіл "Завжди дозволяти" надано
  RequestPermissionManager onPermissionAlwaysGranted(
    final Function()? onPermissionAlwaysGranted,
  ) {
    _onPermissionAlwaysGranted = onPermissionAlwaysGranted;
    return this;
  }

  /// get Permission from PermissionType enum value
  Permission _getPermissionFromType(final PermissionType permissionType) {
    switch (permissionType) {
      case PermissionType.camera:
        return Permission.camera;
      case PermissionType.storage:
        return Permission.storage;
      case PermissionType.whenInUseLocation:
        return Permission.locationWhenInUse;
      case PermissionType.alwaysLocation:
        return Permission.locationAlways;
      case PermissionType.location:
        return Permission.location;
      case PermissionType.notification:
        return Permission.notification;
      case PermissionType.photos:
        return Permission.photos;
      case PermissionType.mediaLibrary:
        return Permission.mediaLibrary;
      default:
        throw Exception('Invalid permission type');
    }
  }

  /// execute request permission
  /// gets permission from PermissionType enum value and request permission
  /// handle permission status and call callback function
  /// if permission is granted, call onPermissionGranted callback
  /// if permission is denied, call onPermissionDenied callback
  /// if permission is permanently denied, call onPermissionPermanentlyDenied callback
  void execute() async {
    final Permission permission = _getPermissionFromType(_permissionType!);

    if (permission == Permission.locationWhenInUse ||
        permission == Permission.locationAlways ||
        permission == Permission.location) {
      if (kDebugMode) {
        print("****************************");
      }
      await permission.shouldShowRequestRationale;
    }
    final PermissionStatus status = await permission.request();
    if (kDebugMode) {
      print("status");
    }
    if (kDebugMode) {
      print(status);
    }

    if (status.isGranted) {
      if (_onPermissionGranted != null) {
        _onPermissionGranted!();
      }
    } else if (status.isDenied) {
      if (_onPermissionDenied != null) {
        _onPermissionDenied!();
      }
    } else if (status.isPermanentlyDenied) {
      if (_onPermissionPermanentlyDenied != null) {
        _onPermissionPermanentlyDenied!();
      }
    } else if (status.isGranted) {
      if (_onPermissionAlwaysGranted != null) {
        _onPermissionAlwaysGranted!();
      }
    }
  }
}
