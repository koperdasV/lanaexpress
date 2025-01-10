import 'package:get/get.dart';
import 'package:lanaexpress/core/http_client/dio_client.dart';
import 'package:lanaexpress/domain/models/blocked_units.dart';
import 'package:lanaexpress/domain/responses/bids_response.dart';

class NotificationService {
  static NotificationService get to => Get.put(NotificationService());

  Future<List<BidsResponse>?> getBidsList() async {
    return DioClient.instance
        .processGet(
      'https://tms.lana.express/api/v1/driver-bid/list',
    )
        .then((final response) {
      List<BidsResponse> result = <BidsResponse>[];
      result = (response.data['data']['data'] as List<dynamic>)
          .map((final dynamic e) => BidsResponse.fromJson(e))
          .toList();
      return result;
    });
  }
  
  Future<List<BlocedUnits>?> getBlockedUnits() async {
    return DioClient.instance
        .processGet(
      'https://tms.lana.express/api/v1/get-blocked-units',
    )
        .then((final response) {
      List<BlocedUnits> result = <BlocedUnits>[];
      result = (response.data['data'] as List<dynamic>)
          .map((final dynamic e) => BlocedUnits.fromJson(e))
          .toList();
      return result;
    });
  }


}
