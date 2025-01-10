// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i20;
import 'package:flutter/cupertino.dart' as _i22;
import 'package:flutter/foundation.dart' as _i24;
import 'package:flutter/material.dart' as _i23;
import 'package:lanaexpress/domain/models/lana_files.dart' as _i25;
import 'package:lanaexpress/ui/bids/bids_view.dart' as _i1;
import 'package:lanaexpress/ui/loadboard/loadboard_view.dart' as _i5;
import 'package:lanaexpress/ui/loads/loads_view.dart' as _i8;
import 'package:lanaexpress/ui/loads_details/loads_details.dart' as _i7;
import 'package:lanaexpress/ui/loads_details/loads_details_view.dart' as _i6;
import 'package:lanaexpress/ui/loads_details/loads_details_viewmodel.dart'
    as _i21;
import 'package:lanaexpress/ui/loads_details/pages/details_page.dart' as _i2;
import 'package:lanaexpress/ui/loads_details/pages/documents_page.dart' as _i3;
import 'package:lanaexpress/ui/loads_details/pages/map_page.dart' as _i11;
import 'package:lanaexpress/ui/loads_details/pages/stops_page.dart' as _i17;
import 'package:lanaexpress/ui/loads_details/upload_photo_view.dart' as _i19;
import 'package:lanaexpress/ui/login/login_view.dart' as _i9;
import 'package:lanaexpress/ui/main/main_mobile.dart' as _i10;
import 'package:lanaexpress/ui/notification/notification_view.dart' as _i12;
import 'package:lanaexpress/ui/onboarding/on_board_page.dart' as _i13;
import 'package:lanaexpress/ui/profile/profile_view.dart' as _i14;
import 'package:lanaexpress/ui/splash/spalsh_view.dart' as _i15;
import 'package:lanaexpress/ui/status/status_view.dart' as _i16;
import 'package:lanaexpress/ui/success/success_view.dart' as _i18;
import 'package:lanaexpress/utils/hold_widget/hold_view.dart' as _i4;

abstract class $AppRouter extends _i20.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i20.PageFactory> pagesMap = {
    BidsView.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BidsView(),
      );
    },
    DetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsRouteArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.DetailsPage(
          viewModel: args.viewModel,
          key: args.key,
        ),
      );
    },
    DocumentsRoute.name: (routeData) {
      final args = routeData.argsAs<DocumentsRouteArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.DocumentsPage(
          viewModel: args.viewModel,
          key: args.key,
        ),
      );
    },
    HoldView.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HoldView(),
      );
    },
    LoadBoardView.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.LoadBoardView(),
      );
    },
    LoadsDetailsView.name: (routeData) {
      final args = routeData.argsAs<LoadsDetailsViewArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.LoadsDetailsView(
          loadsId: args.loadsId,
          key: args.key,
        ),
      );
    },
    LoadsNavigationBar.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.LoadsNavigationBar(),
      );
    },
    LoadsView.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.LoadsView(),
      );
    },
    LoginView.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.LoginView(),
      );
    },
    MainMobile.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.MainMobile(),
      );
    },
    MapRoute.name: (routeData) {
      final args = routeData.argsAs<MapRouteArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.MapPage(
          viewModel: args.viewModel,
          key: args.key,
        ),
      );
    },
    NotificationView.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.NotificationView(),
      );
    },
    OnBoardingScreen.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.OnBoardingScreen(),
      );
    },
    ProfileView.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.ProfileView(),
      );
    },
    SplashView.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.SplashView(),
      );
    },
    StatusView.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.StatusView(),
      );
    },
    StopsRoute.name: (routeData) {
      final args = routeData.argsAs<StopsRouteArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.StopsPage(
          viewModel: args.viewModel,
          key: args.key,
        ),
      );
    },
    SuccessView.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.SuccessView(),
      );
    },
    UploadPhotoView.name: (routeData) {
      final args = routeData.argsAs<UploadPhotoViewArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.UploadPhotoView(
          loadsId: args.loadsId,
          typeFile: args.typeFile,
          fileType: args.fileType,
          listPhoto: args.listPhoto,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.BidsView]
class BidsView extends _i20.PageRouteInfo<void> {
  const BidsView({List<_i20.PageRouteInfo>? children})
      : super(
          BidsView.name,
          initialChildren: children,
        );

  static const String name = 'BidsView';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DetailsPage]
class DetailsRoute extends _i20.PageRouteInfo<DetailsRouteArgs> {
  DetailsRoute({
    required _i21.LoadsDetailsViewModel viewModel,
    _i22.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          DetailsRoute.name,
          args: DetailsRouteArgs(
            viewModel: viewModel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailsRoute';

  static const _i20.PageInfo<DetailsRouteArgs> page =
      _i20.PageInfo<DetailsRouteArgs>(name);
}

class DetailsRouteArgs {
  const DetailsRouteArgs({
    required this.viewModel,
    this.key,
  });

  final _i21.LoadsDetailsViewModel viewModel;

  final _i22.Key? key;

  @override
  String toString() {
    return 'DetailsRouteArgs{viewModel: $viewModel, key: $key}';
  }
}

/// generated route for
/// [_i3.DocumentsPage]
class DocumentsRoute extends _i20.PageRouteInfo<DocumentsRouteArgs> {
  DocumentsRoute({
    required _i21.LoadsDetailsViewModel viewModel,
    _i23.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          DocumentsRoute.name,
          args: DocumentsRouteArgs(
            viewModel: viewModel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'DocumentsRoute';

  static const _i20.PageInfo<DocumentsRouteArgs> page =
      _i20.PageInfo<DocumentsRouteArgs>(name);
}

class DocumentsRouteArgs {
  const DocumentsRouteArgs({
    required this.viewModel,
    this.key,
  });

  final _i21.LoadsDetailsViewModel viewModel;

  final _i23.Key? key;

  @override
  String toString() {
    return 'DocumentsRouteArgs{viewModel: $viewModel, key: $key}';
  }
}

/// generated route for
/// [_i4.HoldView]
class HoldView extends _i20.PageRouteInfo<void> {
  const HoldView({List<_i20.PageRouteInfo>? children})
      : super(
          HoldView.name,
          initialChildren: children,
        );

  static const String name = 'HoldView';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LoadBoardView]
class LoadBoardView extends _i20.PageRouteInfo<void> {
  const LoadBoardView({List<_i20.PageRouteInfo>? children})
      : super(
          LoadBoardView.name,
          initialChildren: children,
        );

  static const String name = 'LoadBoardView';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i6.LoadsDetailsView]
class LoadsDetailsView extends _i20.PageRouteInfo<LoadsDetailsViewArgs> {
  LoadsDetailsView({
    required int loadsId,
    _i23.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          LoadsDetailsView.name,
          args: LoadsDetailsViewArgs(
            loadsId: loadsId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'LoadsDetailsView';

  static const _i20.PageInfo<LoadsDetailsViewArgs> page =
      _i20.PageInfo<LoadsDetailsViewArgs>(name);
}

class LoadsDetailsViewArgs {
  const LoadsDetailsViewArgs({
    required this.loadsId,
    this.key,
  });

  final int loadsId;

  final _i23.Key? key;

  @override
  String toString() {
    return 'LoadsDetailsViewArgs{loadsId: $loadsId, key: $key}';
  }
}

/// generated route for
/// [_i7.LoadsNavigationBar]
class LoadsNavigationBar extends _i20.PageRouteInfo<void> {
  const LoadsNavigationBar({List<_i20.PageRouteInfo>? children})
      : super(
          LoadsNavigationBar.name,
          initialChildren: children,
        );

  static const String name = 'LoadsNavigationBar';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i8.LoadsView]
class LoadsView extends _i20.PageRouteInfo<void> {
  const LoadsView({List<_i20.PageRouteInfo>? children})
      : super(
          LoadsView.name,
          initialChildren: children,
        );

  static const String name = 'LoadsView';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i9.LoginView]
class LoginView extends _i20.PageRouteInfo<void> {
  const LoginView({List<_i20.PageRouteInfo>? children})
      : super(
          LoginView.name,
          initialChildren: children,
        );

  static const String name = 'LoginView';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i10.MainMobile]
class MainMobile extends _i20.PageRouteInfo<void> {
  const MainMobile({List<_i20.PageRouteInfo>? children})
      : super(
          MainMobile.name,
          initialChildren: children,
        );

  static const String name = 'MainMobile';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i11.MapPage]
class MapRoute extends _i20.PageRouteInfo<MapRouteArgs> {
  MapRoute({
    required _i21.LoadsDetailsViewModel viewModel,
    _i24.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          MapRoute.name,
          args: MapRouteArgs(
            viewModel: viewModel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static const _i20.PageInfo<MapRouteArgs> page =
      _i20.PageInfo<MapRouteArgs>(name);
}

class MapRouteArgs {
  const MapRouteArgs({
    required this.viewModel,
    this.key,
  });

  final _i21.LoadsDetailsViewModel viewModel;

  final _i24.Key? key;

  @override
  String toString() {
    return 'MapRouteArgs{viewModel: $viewModel, key: $key}';
  }
}

/// generated route for
/// [_i12.NotificationView]
class NotificationView extends _i20.PageRouteInfo<void> {
  const NotificationView({List<_i20.PageRouteInfo>? children})
      : super(
          NotificationView.name,
          initialChildren: children,
        );

  static const String name = 'NotificationView';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i13.OnBoardingScreen]
class OnBoardingScreen extends _i20.PageRouteInfo<void> {
  const OnBoardingScreen({List<_i20.PageRouteInfo>? children})
      : super(
          OnBoardingScreen.name,
          initialChildren: children,
        );

  static const String name = 'OnBoardingScreen';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i14.ProfileView]
class ProfileView extends _i20.PageRouteInfo<void> {
  const ProfileView({List<_i20.PageRouteInfo>? children})
      : super(
          ProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ProfileView';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i15.SplashView]
class SplashView extends _i20.PageRouteInfo<void> {
  const SplashView({List<_i20.PageRouteInfo>? children})
      : super(
          SplashView.name,
          initialChildren: children,
        );

  static const String name = 'SplashView';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i16.StatusView]
class StatusView extends _i20.PageRouteInfo<void> {
  const StatusView({List<_i20.PageRouteInfo>? children})
      : super(
          StatusView.name,
          initialChildren: children,
        );

  static const String name = 'StatusView';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i17.StopsPage]
class StopsRoute extends _i20.PageRouteInfo<StopsRouteArgs> {
  StopsRoute({
    required _i21.LoadsDetailsViewModel viewModel,
    _i23.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          StopsRoute.name,
          args: StopsRouteArgs(
            viewModel: viewModel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'StopsRoute';

  static const _i20.PageInfo<StopsRouteArgs> page =
      _i20.PageInfo<StopsRouteArgs>(name);
}

class StopsRouteArgs {
  const StopsRouteArgs({
    required this.viewModel,
    this.key,
  });

  final _i21.LoadsDetailsViewModel viewModel;

  final _i23.Key? key;

  @override
  String toString() {
    return 'StopsRouteArgs{viewModel: $viewModel, key: $key}';
  }
}

/// generated route for
/// [_i18.SuccessView]
class SuccessView extends _i20.PageRouteInfo<void> {
  const SuccessView({List<_i20.PageRouteInfo>? children})
      : super(
          SuccessView.name,
          initialChildren: children,
        );

  static const String name = 'SuccessView';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i19.UploadPhotoView]
class UploadPhotoView extends _i20.PageRouteInfo<UploadPhotoViewArgs> {
  UploadPhotoView({
    required int loadsId,
    required String typeFile,
    required String fileType,
    required List<_i25.LanaFiles> listPhoto,
    _i22.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          UploadPhotoView.name,
          args: UploadPhotoViewArgs(
            loadsId: loadsId,
            typeFile: typeFile,
            fileType: fileType,
            listPhoto: listPhoto,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'UploadPhotoView';

  static const _i20.PageInfo<UploadPhotoViewArgs> page =
      _i20.PageInfo<UploadPhotoViewArgs>(name);
}

class UploadPhotoViewArgs {
  const UploadPhotoViewArgs({
    required this.loadsId,
    required this.typeFile,
    required this.fileType,
    required this.listPhoto,
    this.key,
  });

  final int loadsId;

  final String typeFile;

  final String fileType;

  final List<_i25.LanaFiles> listPhoto;

  final _i22.Key? key;

  @override
  String toString() {
    return 'UploadPhotoViewArgs{loadsId: $loadsId, typeFile: $typeFile, fileType: $fileType, listPhoto: $listPhoto, key: $key}';
  }
}
