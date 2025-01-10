import 'dart:async';
import 'package:get/get.dart';
import 'package:lanaexpress/core/http_client/dio_client.dart';
import 'package:lanaexpress/domain/models/drivers_info.dart';
import 'package:lanaexpress/domain/models/user_info_model.dart';

final class StatusService {
  static StatusService get to => Get.put(StatusService());

  Future<UserInfo?> getUserInfo() async {
    return DioClient.instance
        .processGet(
      'https://tms.lana.express/api/v1/user/get-info',
    )
        .then((response) {
      final Map<String, dynamic>? responseData = response.data;
      return responseData != null ? UserInfo.fromJson(responseData) : null;
    });
  }

  Future<List<DriversInfo>?> getDriversInfoList() async {
    return DioClient.instance
        .processGet(
      'https://tms.lana.express/api/v1/get-drivers-with-units-info',
    )
        .then((final response) {
      List<DriversInfo> result = <DriversInfo>[];
      result = (response.data as List<dynamic>)
          .map((final e) => DriversInfo.fromJson(e))
          .toList();
      return result;
    });
  }

  Future<bool> changeDriverStatus(
      final int driverId, final int statusId) async {
    return DioClient.instance.processPost(
        'https://tms.lana.express/api/v1/chnage-driver-status?driver_id=$driverId&status=$statusId',
        data: <String, int>{
          'driver_id': driverId,
          'status': statusId,
        }).then((final response) {
      bool isSuccess = false;
      if (response.statusCode == 200) {
        isSuccess = true;
      }
      return isSuccess;
    });
  }

  Future<bool> updateDriverLocation(
    final int driverId,
    final double lat,
    final double lng,
    final String? currentZip,
    final String? state,
    final String? currentLocation,
    final String? timeOnPoint,
  ) async {
    return DioClient.instance.processPost(
        'https://tms.lana.express/api/v1/update-driver-location',
        data: <String, dynamic>{
          "driver_id": driverId,
          "current_zip": currentZip,
          "current_location": currentLocation, //"Portland, OR 97230, USA",
          "current_state": state,
          "lat": lat,
          "lng": lng,
          "time_on_point": timeOnPoint, //"2024-07-19 10:20:00"
        }).then((final response) {
      bool isSuccess = false;
      if (response.statusCode == 200) {
        isSuccess = true;
      }
      return isSuccess;
    });
  }
}
