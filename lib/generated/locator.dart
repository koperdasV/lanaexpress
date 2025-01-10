import 'package:get_it/get_it.dart';
import 'package:lanaexpress/core/http_client/dio_client.dart';
import 'package:lanaexpress/data/source/preference_manager.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<PreferenceManager>(() => PreferenceManager());
  //DioClient.urlBase = 'https://tms.lana.express/api/v1/';
  DioClient.configure();
}
