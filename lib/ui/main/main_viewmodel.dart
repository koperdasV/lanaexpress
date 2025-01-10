import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/core/base/ui/base_controller.dart';
import 'package:lanaexpress/core/services/notification_service.dart';
import 'package:lanaexpress/data/managers/logger/log_manager.dart';
import 'package:lanaexpress/domain/models/blocked_units.dart';
import 'package:lanaexpress/ui/bids/bids_view.dart';
import 'package:lanaexpress/ui/loadboard/loadboard_view.dart';
import 'package:lanaexpress/ui/loads/loads_view.dart';
import 'package:lanaexpress/ui/profile/profile_view.dart';
import 'package:lanaexpress/ui/status/status_view.dart';

class MainViewModel extends BaseController {
  List<PageRouteInfo<dynamic>> pagesMobile = <PageRouteInfo>[];

  int selectedIndex = 0;
  List<Widget> _pages = const <Widget>[
    StatusView(),
    LoadBoardView(),
    BidsView(),
    LoadsView(),
    ProfileView(),
  ];

  List<Widget> get pages => _pages;

  set pages(final List<Widget> pages) {
    _pages = pages;
    notifyListeners();
  }

  void onItemTapped(final int index) {
    selectedIndex = index;
    notifyListeners();
  }

  List<BottomNavigationBarItem> buildMobileNavItems() {
    final List<BottomNavigationBarItem> itemsToAdd = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Image.asset(AssetsIcons.icStatus),
        activeIcon: Image.asset(AssetsIcons.icActiveStatus),
        label: NavBarTitles.status,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(AssetsIcons.icLoadboard),
        activeIcon: Image.asset(AssetsIcons.icActiveLoadboard),
        label: NavBarTitles.loadboard,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(AssetsIcons.icBids),
        activeIcon: Image.asset(AssetsIcons.icActiveBids),
        label: NavBarTitles.bids,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(AssetsIcons.icLoads),
        activeIcon: Image.asset(AssetsIcons.icActiveLoads),
        label: NavBarTitles.loads,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(AssetsIcons.icProfile),
        activeIcon: Image.asset(AssetsIcons.icActiveProfile),
        label: NavBarTitles.profile,
      ),
    ];
    late final List<BottomNavigationBarItem> result =
        <BottomNavigationBarItem>[];
    for (int i = 0; i < itemsToAdd.length; i++) {
      if (i == 0) {
        result.add(itemsToAdd[i]);
      } else if (i == 1) {
        result.add(itemsToAdd[i]);
      } else if (i == 2) {
        result.add(itemsToAdd[i]);
      } else if (i == 3) {
        result.add(itemsToAdd[i]);
      } else {
        result.add(itemsToAdd[i]);
      }
    }
    return result;
  }

  void init() async {
    selectedIndex = 0;
    await getBlockedUnits();
    // Timer.periodic(const Duration(seconds: 20), (final Timer timer) async {
    //   await getBlockedUnits();
    // });
  }
  late final NotificationService _notificationService = NotificationService.to;

  List<BlocedUnits>? _blockedUnitsList = <BlocedUnits>[];
  List<BlocedUnits>? get blockedUnitsList => _blockedUnitsList;

  Future<List<BlocedUnits>?> getBlockedUnits() async {
    setBusy(true);
    try {
      final List<BlocedUnits>? res =
          await _notificationService.getBlockedUnits();
      if (res!.isNotEmpty) {
        _blockedUnitsList = res;
        setBusy(false);
        notifyListeners();
      } else {
        _blockedUnitsList = <BlocedUnits>[];
        setBusy(false);
      }
      return _blockedUnitsList;
    } catch (e, stackTrace) {
      LogManager().log(e, stackTrace);
      setBusy(false);
      return <BlocedUnits>[];
    }
  }
}
