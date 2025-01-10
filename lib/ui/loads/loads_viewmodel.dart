import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/core/base/ui/base_controller.dart';
import 'package:lanaexpress/core/services/loads_service.dart';
import 'package:lanaexpress/data/managers/logger/log_manager.dart';
import 'package:lanaexpress/domain/models/driver_bid.dart';
import 'package:lanaexpress/domain/models/loadboard_filter.dart';
import 'package:lanaexpress/domain/models/loads_model.dart';
import 'package:lanaexpress/domain/models/user_info_model.dart';
import 'package:lanaexpress/ui/loadboard/loadboard_viewmodel.dart';
import 'package:lanaexpress/ui/status/status_viewmodel.dart';

class LoadsViewModel extends BaseController {
  final LoadsService _loadsService = LoadsService.to;
  TextEditingController sumController = TextEditingController();
  TextEditingController pricePerMileController = TextEditingController();

  List<LoadsResponse> _loads = <LoadsResponse>[];

  List<LoadsResponse> get loads => _loads;

  set loads(final List<LoadsResponse> loads) {
    _loads = loads;
    notifyListeners();
  }

  DriverBid _driverBid = DriverBid();

  DriverBid get driverBid => _driverBid;

  set driverBid(final DriverBid driverBid) {
    _driverBid = driverBid;
    notifyListeners();
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(final int currentIndex) {
    _currentIndex = currentIndex;
    notifyListeners();
  }

  Driver? _currentDriver;

  Driver? get currentDriver => _currentDriver;

  set currentDriver(final Driver? currentDriver) {
    _currentDriver = currentDriver;
    notifyListeners();
  }

  StatusViewModel _statusViewModel = StatusViewModel();

  StatusViewModel get statusViewModel => _statusViewModel;

  set statusViewModel(final StatusViewModel statusViewModel) {
    _statusViewModel = statusViewModel;
    notifyListeners();
  }

  Future<void> init() async {
    setBusy(true);
    await statusViewModel.getDriversInfoList();
    if (statusViewModel.userInfo?.drivers?.isNotEmpty ?? false) {
      currentDriver = statusViewModel.userInfo?.drivers?.first;
    }
    try {
      final List<LoadsResponse>? res = await _loadsService.getLoadsList();
      if (res != null) {
        loads = res;
      } else {
        if (kDebugMode) {
          print('Loadboard info is null');
        }
      }
    } catch (e, stackTrace) {
      LogManager().log(e, stackTrace);
    }
    setBusy(false);
  }

  Future<void> setDriverBid(
    final LoadboardViewModel viewModel,
    final String? price,
  ) async {
    driverBid.driverId = viewModel.statusViewModel.userInfo?.drivers?.first.id;
    driverBid.price = int.tryParse(price ?? '');
    driverBid.companyId =
        viewModel.statusViewModel.userInfo?.drivers?.first.companyId;
    driverBid.loadId = viewModel.loadboards?.first.id;
  }

  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  TextEditingController driverController = TextEditingController();
  final TextEditingController truckTypeController = TextEditingController();

  LoadboardFilter _loadboardFilter = LoadboardFilter();

  LoadboardFilter get loadboardFilter => _loadboardFilter;

  set loadboardFilter(final LoadboardFilter loadboardFilter) {
    _loadboardFilter = loadboardFilter;
    notifyListeners();
  }
  List<int>? _driverIds = [];
  List<int>? get driverIds => _driverIds;

  set driverIds(final List<int>? driverIds) {
    _driverIds = driverIds;
    notifyListeners();
  }

  void setModelData() {
    loadboardFilter.origin = originController.text;
    loadboardFilter.destination = destinationController.text;
    loadboardFilter.distance = double.tryParse(distanceController.text);
    loadboardFilter.driverId = driverIds;
    loadboardFilter.truckType = truckTypeController.text;
    loadboardFilter.weight = int.tryParse(weightController.text);
  }

  // Future<void> applyFilter() async {
  //   setBusy(true);
  //   setModelData();
  //   try {
  //     final List<Loadboard>? res =
  //         await _loadboardService.getLoadboardFilterList(loadboardFilter);

  //     if (res != null) {
  //       loadboards = res;
  //     } else {
  //       if (kDebugMode) {
  //         print('Loadboard info is null');
  //       }
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  //   setBusy(false);
  // }
}
