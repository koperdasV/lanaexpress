import 'dart:async';
import 'package:get/get.dart';
import 'package:lanaexpress/core/http_client/dio_client.dart';
import 'package:lanaexpress/domain/models/driver_bid.dart';
import 'package:lanaexpress/domain/models/loadboard_filter.dart';
import 'package:lanaexpress/domain/models/loadboard_model.dart';

class LoadboardService {
  static LoadboardService get to => Get.put(LoadboardService());
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // late ConfirmationResult confirmationResult;

  Future<List<Loadboard>?> getLoadboardList(int page) async {
    return DioClient.instance
        .processGet(
      'https://tms.lana.express/api/v1/loadboard/list',
    )
        .then((response) {
      List<Loadboard> result = <Loadboard>[];
      int currentPage = 0;
      int lastPage = 0;
      if (response.data['current_page'] != null) {
        currentPage = response.data['current_page'];
      }

      if (response.data['last_page'] != null) {
        lastPage = response.data['last_page'];
      }
      result = (response.data['data'] as List)
          .map((e) => Loadboard.fromJson(e))
          .toList();
      return result;
    });
  }

  Future<DriverBid?> makeBidForDriver(DriverBid? model) async {
    return DioClient.instance
        .processPost('https://tms.lana.express/api/v1/driver-bid/create',
            data: model?.toJson())
        .then((response) {
      return DriverBid.fromJson(response.data['data']);
    });
  }

  Future<List<Loadboard>?> getLoadboardFilterList(
      LoadboardFilter loadboardFilter) async {
    return DioClient.instance.processGet(
      'https://tms.lana.express/api/v1/loadboard/list',
      queryParameters: {
        'origin': loadboardFilter.origin,
        'destination': loadboardFilter.destination,
        'distance': loadboardFilter.distance,
        'driver_id': loadboardFilter.driverId,
        'truck_type': loadboardFilter.truckType,
        'weight': loadboardFilter.weight,
      },
    ).then((response) {
      List<Loadboard> result = <Loadboard>[];
      result = (response.data['data'] as List)
          .map((e) => Loadboard.fromJson(e))
          .toList();
      return result;
    });
  }
}
