import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/core/base/ui/base_controller.dart';
import 'package:lanaexpress/core/services/loadboard_service.dart';
import 'package:lanaexpress/data/managers/logger/log_manager.dart';
import 'package:lanaexpress/domain/models/driver_bid.dart';
import 'package:lanaexpress/domain/models/drivers_info.dart';
import 'package:lanaexpress/domain/models/loadboard_filter.dart';
import 'package:lanaexpress/domain/models/loadboard_model.dart';
import 'package:lanaexpress/generated/router.dart';
import 'package:lanaexpress/generated/router.gr.dart' as gr;
import 'package:lanaexpress/ui/loadboard/filter_dialog/filter_dialog.dart';
import 'package:lanaexpress/ui/status/status_viewmodel.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

final class LoadboardViewModel extends BaseController {
  late final LoadboardService _loadboardService = LoadboardService.to;
  late final TextEditingController sumController = TextEditingController();
  late final TextEditingController pricePerMileController =
      TextEditingController();

  List<Loadboard>? _loadboards = <Loadboard>[];

  List<Loadboard>? get loadboards => _loadboards;

  set loadboards(final List<Loadboard>? loadboards) {
    _loadboards = loadboards;
    notifyListeners();
  }

  DriverBid _driverBid = DriverBid();

  DriverBid get driverBid => _driverBid;

  set driverBid(final DriverBid driverBid) {
    _driverBid = driverBid;
    notifyListeners();
  }

  bool isLoading = false;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  DriversInfo? _currentDriver;
  DriversInfo? get currentDriver => _currentDriver;

  set currentDriver(final DriversInfo? currentDriver) {
    _currentDriver = currentDriver;
    notifyListeners();
  }

  DriversInfo? _selectCurrentDriver;
  DriversInfo? get selectCurrentDriver => _selectCurrentDriver;

  set selectCurrentDriver(final DriversInfo? selectCurrentDriver) {
    _selectCurrentDriver = selectCurrentDriver;
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
      currentDriver = statusViewModel.currentDriver;
    }
    try {
      final List<Loadboard>? res =
          await _loadboardService.getLoadboardList(_currentIndex);
      if (res != null) {
        _loadboards = res;
      } else {
        if (kDebugMode) {
          print('Loadboard info is null');
        }
      }
    } catch (e, stackTrace) {
      LogManager().log(e, stackTrace);
      //showWebColoredToast(e.toString());
    }
    setBusy(false);
  }

  Future<void> loadMoreData() async {
    isLoading = true;
    try {
      // Викликаємо метод сервісу, щоб отримати наступну сторінку даних
      final List<Loadboard>? nextPageData =
          await _loadboardService.getLoadboardList(_currentIndex + 1);
      if (nextPageData != null && nextPageData.isNotEmpty) {
        // Додаємо отримані дані до загального списку
        loadboards?.addAll(nextPageData);
        _currentIndex++;
        isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      LogManager().log(error.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setDriverBid(
    final Loadboard? loadboard,
    final String? price,
    final LoadboardViewModel viewModel,
  ) async {
    driverBid.driverId = viewModel.currentDriver?.driverId;
    //userInfo?.drivers?.first.id;
    driverBid.price = int.tryParse(price ?? '');
    // driverBid.companyId =
    //     viewModel.statusViewModel.currentDriver.;
    driverBid.loadId = loadboard?.id;
  }

  Future<void> applyBid() async {
    try {
      final DriverBid? res =
          await _loadboardService.makeBidForDriver(driverBid);
      if (res != null) {
        router.push(const gr.SuccessView());
      }
    } catch (e) {
      debugPrint("Error applying bid: $e");
    }
  }

  late final TextEditingController originController = TextEditingController();
  late final TextEditingController destinationController =
      TextEditingController();
  late final TextEditingController weightController = TextEditingController();
  late final TextEditingController distanceController = TextEditingController();
  late final TextEditingController driverController = TextEditingController();
  late final MultiSelectController<TruckType>? truckTypeController =
      MultiSelectController<TruckType>();

  double lat = 0.0;
  double lng = 0.0;

  LoadboardFilter _loadboardFilter = LoadboardFilter();

  LoadboardFilter get loadboardFilter => _loadboardFilter;

  set loadboardFilter(final LoadboardFilter loadboardFilter) {
    _loadboardFilter = loadboardFilter;
    notifyListeners();
  }

  List<int>? _driverIds = <int>[];
  List<int>? get driverIds => _driverIds;

  set driverIds(final List<int>? driverIds) {
    _driverIds = driverIds;
    notifyListeners();
  }

  TruckType? _trackType;
  TruckType? get trackType => _trackType;

  set trackType(final TruckType? trackType) {
    _trackType = trackType;
    notifyListeners();
  }

  void setModelData() {
    loadboardFilter.origin = originController.text;
    loadboardFilter.destination = destinationController.text;
    loadboardFilter.distance = double.tryParse(distanceController.text);
    loadboardFilter.driverId = driverIds;
    loadboardFilter.truckType = truckTypeController?.options.first.label;
    loadboardFilter.weight = int.tryParse(weightController.text);
  }

  Future<void> applyFilter() async {
    setBusy(true);
    setModelData();
    try {
      final List<Loadboard>? res =
          await _loadboardService.getLoadboardFilterList(loadboardFilter);

      if (res != null) {
        loadboards = res;
      } else {
        if (kDebugMode) {
          print('Loadboard info is null');
        }
      }
    } catch (e) {
      LogManager().log(e.toString());
    }
    setBusy(false);
  }

  Future<void> refreshLoadboard() async {
    setBusy(true);
    final List<Loadboard>? loadboardRefreshList =
        await _loadboardService.getLoadboardList(_currentIndex);
    loadboards = loadboardRefreshList;
    notifyListeners();
    setBusy(false);
  }
}
