// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:lanaexpress/core/base/ui/base_controller.dart';
// import 'package:lanaexpress/core/services/loadboard_service.dart';
// import 'package:lanaexpress/domain/models/loadboard_filter.dart';
// import 'package:lanaexpress/domain/models/loadboard_model.dart';
// import 'package:lanaexpress/domain/models/user_info_model.dart';
// import 'package:lanaexpress/ui/loadboard/loadboard_viewmodel.dart';
// import 'package:lanaexpress/ui/status/status_viewmodel.dart';

// class FilterDialogViewModel extends BaseController {
//   final LoadboardService _loadboardService = LoadboardService.to;
//   final TextEditingController originController = TextEditingController();
//   final TextEditingController destinationController = TextEditingController();
//   final TextEditingController weightController = TextEditingController();
//   final TextEditingController distanceController = TextEditingController();
//   final TextEditingController driverController = TextEditingController();
//   final TextEditingController truckTypeController = TextEditingController();

//   Driver? _currentDriver;

//   Driver? get currentDriver => _currentDriver;

//   set currentDriver(Driver? currentDriver) {
//     _currentDriver = currentDriver;
//     notifyListeners();
//   }

//   LoadboardFilter _loadboardFilter = LoadboardFilter();

//   LoadboardFilter get loadboardFilter => _loadboardFilter;

//   set loadboardFilter(LoadboardFilter loadboardFilter) {
//     _loadboardFilter = loadboardFilter;
//     notifyListeners();
//   }

//   List<Loadboard> _loadboardsFilterList = <Loadboard>[];

//   List<Loadboard> get loadboardsFilterList => _loadboardsFilterList;

//   set loadboardsFilterList(List<Loadboard> loadboardsFilterList) {
//     _loadboardsFilterList = loadboardsFilterList;
//     notifyListeners();
//   }

//   StatusViewModel _statusViewModel = StatusViewModel();

//   StatusViewModel get statusViewModel => _statusViewModel;

//   set statusViewModel(StatusViewModel statusViewModel) {
//     _statusViewModel = statusViewModel;
//     notifyListeners();
//   }

//   LoadboardViewModel _loadboardViewModel = LoadboardViewModel();

//   LoadboardViewModel get loadboardViewModel => _loadboardViewModel;

//   set loadboardViewModel(LoadboardViewModel loadboardViewModel) {
//     _loadboardViewModel = loadboardViewModel;
//     notifyListeners();
//   }

//   UserInfo? _userInfo;

//   UserInfo? get userInfo => _userInfo;

//   set userInfo(UserInfo? userInfo) {
//     _userInfo = userInfo;
//     notifyListeners();
//   }

//   Future<void> init() async {
//     setBusy(true);
//     //setInitModelData();
//     await statusViewModel.getUserInfo();
//     if (userInfo?.drivers?.isNotEmpty ?? false) {
//       currentDriver = userInfo?.drivers?.first;
//     }
//     setBusy(false);
//   }
//   // void setInitModelData() {
//   //   originController.text = loadboardFilter.origin ?? '';
//   //   destinationController.text = loadboardFilter.destination ?? '';
//   //   distanceController.text = loadboardFilter.distance.toString();
//   //   driverController.text = loadboardFilter.driverId.toString();
//   //   truckTypeController.text = loadboardFilter.truckType ?? '';
//   //   weightController.text = loadboardFilter.weight.toString();
//   // }


//   void setModelData() {
//     loadboardFilter.origin = originController.text;
//     loadboardFilter.destination = destinationController.text;
//     loadboardFilter.distance = double.tryParse(distanceController.text);
//     loadboardFilter.driverId = int.tryParse(driverController.text);
//     loadboardFilter.truckType = truckTypeController.text;
//     loadboardFilter.weight = int.tryParse(weightController.text);
//   }

//   Future<void> applyFilter() async {
//     setBusy(true);
//     setModelData();
//     try {
//       final List<Loadboard>? res =
//           await _loadboardService.getLoadboardFilterList(loadboardFilter);

//       if (res != null) {
//         loadboardsFilterList = res;
//         // final List<Loadboard> loadboards =
//         //     Loadboard.fromJson(res as Map<String, dynamic>)
//         //         as List<Loadboard>;
//       } else {
//         if (kDebugMode) {
//           print('Loadboard info is null');
//         }
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//     setBusy(false);
//   }
// }
