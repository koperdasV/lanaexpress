import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/generated/router.gr.dart';

final AppRouter router = AppRouter();

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends $AppRouter {

  factory AppRouter() {
    return _appRouter;
  }

  AppRouter._internal();
  static final AppRouter _appRouter = AppRouter._internal();

  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          page: SplashView.page,
          initial: true,
          path: '/',
        ),
        CustomRoute(
            page: LoginView.page,
            transitionsBuilder: TransitionsBuilders.fadeIn,
            path: '/login',),
        AutoRoute(
          page: OnBoardingScreen.page,
        ),
        AutoRoute(page: MainMobile.page),
        AutoRoute(page: StatusView.page),
        AutoRoute(page: LoadBoardView.page),
        AutoRoute(page: BidsView.page),
        AutoRoute(page: SuccessView.page),
        AutoRoute(page: LoadsDetailsView.page),
        CustomRoute(
          page: LoadsView.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 500,
          children: <AutoRoute>[
            AutoRoute(
              page: DetailsRoute.page,
              maintainState: false,
            ),
            AutoRoute(
              page: StopsRoute.page,
              maintainState: false,
            ),
            AutoRoute(
              page: MapRoute.page,
              maintainState: false,
            ),
            AutoRoute(
              page: DocumentsRoute.page,
              maintainState: false,
            ),
          ],
        ),
        AutoRoute(page: NotificationView.page),
        AutoRoute(page: LoadsNavigationBar.page),
      ];
}

class MyObserver extends AutoRouterObserver {
  @override
  void didPush(final Route route, final Route? previousRoute) {
    debugPrint('[ROUTE INFO MANAGER] New route pushed: ${route.settings.name}');
    debugPrint(
        '[ROUTE INFO MANAGER] Previous route: ${previousRoute?.settings.name}',);
  }

  @override
  void didInitTabRoute(final TabPageRoute route, final TabPageRoute? previousRoute) {
    debugPrint('[ROUTE INFO MANAGER] Tab route visited:  ${route.name}');
    debugPrint(
        '[ROUTE INFO MANAGER] Previous tab route: ${previousRoute?.name}',);
  }

  @override
  void didChangeTabRoute(final TabPageRoute route, final TabPageRoute previousRoute) {
    debugPrint('[ROUTE INFO MANAGER] Tab route re-visited: ${route.name}');
    debugPrint(
        '[ROUTE INFO MANAGER] Previous tab route: ${previousRoute.name}',);
  }

  @override
  void didPop(final Route? route, final Route? previousRoute) {
    debugPrint('[ROUTE INFO MANAGER] Route is pop: ${route?.settings.name}');
    debugPrint(
        '[ROUTE INFO MANAGER] Previous route: ${previousRoute?.settings.name}',);
  }
}
