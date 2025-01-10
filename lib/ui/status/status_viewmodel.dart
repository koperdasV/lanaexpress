import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lanaexpress/core/base/ui/base_controller.dart';
import 'package:lanaexpress/core/services/status_service.dart';
import 'package:lanaexpress/data/managers/logger/log_manager.dart';
import 'package:lanaexpress/domain/models/drivers_info.dart';
import 'package:lanaexpress/domain/models/user_info_model.dart';
import 'package:lanaexpress/generated/router.dart';
import 'package:lanaexpress/utils/utils.dart';

final class StatusViewModel extends BaseController {
  late final StatusService _statusService = StatusService.to;
  late final TextEditingController originController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  late final TextEditingController dateController = TextEditingController();
  late final TextEditingController timeController = TextEditingController();

  String? timeOnPoint = '';

  LatLng? selectedLocation;

  int? _companyID;
  int? get companyID => _companyID;

  double? _selectedLatitude = 0;
  double? get selectedLatitude => _selectedLatitude;

  set selectedLatitude(final double? selectedLatitude) {
    _selectedLatitude = selectedLatitude;
    notifyListeners();
  }

  double? _selectedLongitude;
  double? get selectedLongitude => _selectedLongitude;

  set selectedLongitude(final double? selectedLongitude) {
    _selectedLongitude = selectedLongitude;
    notifyListeners();
  }

  UserInfo? _userInfo;

  UserInfo? get userInfo => _userInfo;

  set userInfo(final UserInfo? userInfo) {
    _userInfo = userInfo;
    notifyListeners();
  }

  DriversInfo? _currentDriver;

  DriversInfo? get currentDriver => _currentDriver;

  set currentDriver(final DriversInfo? currentDriver) {
    _currentDriver = currentDriver;
    notifyListeners();
  }

  List<DriversInfo>? _driverInfoList = <DriversInfo>[];
  List<DriversInfo>? get driverInfoList => _driverInfoList;

  String? _currentStatus = '';
  String? get currentStatus => _currentStatus;

  set currentStatus(final String? currentStatus) {
    _currentStatus = currentStatus;
    notifyListeners();
  }

  String? _currentZip = '';
  String? get currentZip => _currentZip;

  set currentZip(final String? currentZip) {
    _currentZip = currentZip;
    notifyListeners();
  }

  String? _state = '';
  String? get state => _state;

  set state(final String? state) {
    _state = state;
    notifyListeners();
  }

  String? _currentLocation = '';
  String? get currentLocation => _currentLocation;

  set currentLocation(final String? currentLocation) {
    _currentLocation = currentLocation;
    notifyListeners();
  }

  void selectedDriver(final DriversInfo? value) {
    _currentDriver = value;
    notifyListeners();
  }
  
  String formatDate(final String? date) {
    final DateTime parsedDate = DateTime.parse(date ?? '');
    return DateFormat('MM-dd-yyyy HH:mm').format(parsedDate);
  }

  void init() async {
    await getDriversInfoList();
    _currentDriver = _driverInfoList?.firstWhere(
      (final DriversInfo driver) => driver.status == 1,
      orElse: () => _driverInfoList?.first ?? DriversInfo(),
    );
    await getUserInfo();
  }

  void getCompanyId() {
    if (userInfo?.drivers?.isNotEmpty ?? false) {
      _companyID = userInfo?.drivers?.first.companyId;
      if (kDebugMode) {
        print('First Driver\'s Company ID: $_companyID');
      }
    } else {
      if (kDebugMode) {
        print('No drivers found');
      }
    }
  }

  Future<void> getUserInfo() async {
    setBusy(true);
    try {
      final UserInfo? res = await _statusService.getUserInfo();
      if (res != null) {
        userInfo = res;
      } else {
        if (kDebugMode) {
          print('User info is null');
        }
      }
      setBusy(false);
    } catch (e, stackTrace) {
      LogManager().log(e, stackTrace);
    }
    setBusy(false);
  }

  Future<List<DriversInfo>?> getDriversInfoList() async {
    setBusy(true);
    try {
      final List<DriversInfo>? res = await _statusService.getDriversInfoList();
      if (res!.isNotEmpty) {
        _driverInfoList = res;
        setBusy(false);
        notifyListeners();
      }
      return _driverInfoList;
    } catch (e, stackTrace) {
      LogManager().log(e, stackTrace);
      setBusy(false);
      return <DriversInfo>[];
    }
  }

  Future<void> changeDriverStatus() async {
    setBusy(true);
    try {
      final bool res = await _statusService.changeDriverStatus(
        _currentDriver?.driverId ?? 0,
        1,
      );
      if (res != false) {
        _currentDriver?.status = 1;
        toastCheck('Status active');
        setBusy(false);
      }
    } catch (e) {
      LogManager().log(e);
      toastCheck(e.toString());
      setBusy(false);
    }
    setBusy(false);
  }

  Future<void> driverStatusInActive() async {
    setBusy(true);
    try {
      final bool res = await _statusService.changeDriverStatus(
        _currentDriver?.driverId ?? 0,
        0,
      );
      if (res != false) {
        _currentDriver?.status = 0;
        toastCheck('Status inactive');
        setBusy(false);
      }
    } catch (e) {
      LogManager().log(e);
      toastCheck(e.toString());
      setBusy(false);
    }
    setBusy(false);
  }

  Future<void> updateLocation() async {
    setBusy(true);
    try {
      final DateTime now = DateTime.now();
      final DateTime selectedDateTime = DateTime(
        selectedDate?.year ?? now.year,
        selectedDate?.month ?? now.month,
        selectedDate?.day ?? now.day,
        selectedTime?.hour ?? now.hour,
        selectedTime?.minute ?? now.minute,
      );

      final String formattedDateTime =
          DateFormat('MM/dd/yyyy HH:mm').format(selectedDateTime);
      if (selectedLatitude != 0 && selectedLongitude != 0) {
        final bool res = await _statusService.updateDriverLocation(
          _currentDriver?.driverId ?? 0,
          _selectedLatitude ?? 0,
          _selectedLongitude ?? 0,
          _currentZip,
          _state,
          _currentLocation,
          formattedDateTime,
        );
        if (res != false) {
          await toastCheck('Location Updated');
          currentDriver?.currentLocation = _currentLocation;
          await AppRouter().maybePop();
          setBusy(false);
        }
      }
    } catch (e) {
      LogManager().log(e);
      toastCheck(e.toString());
      setBusy(false);
    }
    setBusy(false);
  }
}
