import 'dart:async';
import 'package:dio/dio.dart';
import 'package:lanaexpress/core/http_client/dio_client.dart';
import 'package:lanaexpress/domain/models/lana_files.dart';
import 'package:lanaexpress/domain/models/loads_model.dart';
import 'package:lanaexpress/domain/models/loads_statuses.dart';
import 'package:path/path.dart';
import 'package:get/get.dart' as getNav;



class LoadsService {
  //static LoadsService get to => Get.put(LoadsService());
  static LoadsService get to => getNav.Get.put(LoadsService());

  Future<List<LoadsResponse>?> getLoadsList() async {
    return DioClient.instance
        .processGet(
      'https://tms.lana.express/api/v1/loads/list',
    )
        .then((final Response<dynamic> response) {
      List<LoadsResponse> result = <LoadsResponse>[];
      result = (response.data['data'] as List<dynamic>)
          .map((final dynamic e) => LoadsResponse.fromJson(e))
          .toList();
      return result;
    });
  }

  Future<LoadsResponse>? getLoadsById(final int loadsId) async {
    return DioClient.instance
        .processGet('https://tms.lana.express/api/v1/loads/$loadsId')
        .then((final Response<dynamic> response) {
      return LoadsResponse.fromJson(response.data);
    });
  }

  Future<List<LoadStatus>>? getLoadsStatuses() async {
    return DioClient.instance
        .processGet('https://tms.lana.express/api/v1/loads/statuses')
        .then((final Response<dynamic> response) {
      if (response != null) {
        final List<LoadStatus> statusList = <LoadStatus>[];
        for (final dynamic entry in response.data.entries) {
          statusList.add(
            LoadStatus.fromJson(<String, dynamic>{
              'id': int.tryParse(entry.key),
              'description': entry.value,
            }),
          );
        }
        return statusList;
      } else {
        return <LoadStatus>[];
      }
    });
  }

  Future<void> changeLoadStatus(final int loadId, final int statusId) async {
    return DioClient.instance.processPost(
      'https://tms.lana.express/api/v1/loads/change-load-status',
      data: <String, int>{
        'load_id': loadId,
        'status': statusId,
      },
    ).then((final Response<dynamic> response) {});
  }

  Future<List<LanaFiles>?> getFiles(
    final int loadsId,
    final String typeFile,
  ) async {
    return DioClient.instance
        .processGet(
      'https://tms.lana.express/api/v1/loads/$loadsId/$typeFile',
    )
        .then((final Response<dynamic> response) {
      List<LanaFiles> result = <LanaFiles>[];
      result = (response.data['data'] as List<dynamic>)
          .map((final dynamic e) => LanaFiles.fromJson(e))
          .toList();
      return result;
    });
  }

  Future<LanaFiles?> uploadFiles(
      final int loadId, final String file, final String fileType,) async {
    final String fileName = basename(file);
    final FormData formData = FormData.fromMap(<String,dynamic >{
        "file": await MultipartFile.fromFile(file, filename: fileName),
        'file_type': fileType,
      });
    return DioClient.instance.processPost(
      'https://tms.lana.express/api/v1/loads/$loadId/file-upload',
      data: formData,
    ).then((final Response<dynamic> response) {
      return LanaFiles.fromJson(response.data);
    });
  }
  
  Future<LanaFiles?> deleteFiles(
      final int loadId, final int fileId,final String fileType,) async {
    return DioClient.instance.processDelete(
      'https://tms.lana.express/api/v1/loads/$loadId/$fileId/file-delete',
      data: <String, String>{
        'file_type': fileType,
      },
    ).then((final Response<dynamic> response) {
      return LanaFiles.fromJson(response.data);
    });
  }
}
