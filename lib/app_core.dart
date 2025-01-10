

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/theme.dart';
import 'package:lanaexpress/generated/router.dart';

final class FurYardApp extends StatefulWidget {
  const FurYardApp({final Key? key}) : super(key: key);

  @override
  State<FurYardApp> createState() => _FurYardAppState();
}

class _FurYardAppState extends State<FurYardApp> {
  @override
  Widget build(final BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        routerDelegate: AutoRouterDelegate(
          router,
          navigatorObservers: () => <NavigatorObserver>[MyObserver()],
        ),
        routeInformationParser: router.defaultRouteParser(),
        routeInformationProvider: router.routeInfoProvider(),
      ),
    );
  }
}
