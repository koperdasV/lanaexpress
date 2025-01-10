import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/data/managers/permission_manager/permission_type.dart';
import 'package:lanaexpress/data/managers/permission_manager/request_permission_manager.dart';
import 'package:lanaexpress/data/source/preference_manager.dart';
import 'package:lanaexpress/generated/router.dart';
import 'package:lanaexpress/generated/router.gr.dart' as gr;
import 'package:lanaexpress/ui/onboarding/components/onboarding_widget.dart';
import 'package:lanaexpress/utils/base_button.dart';
import 'package:lanaexpress/utils/base_text_button.dart';

@RoutePage()
final class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    final List<Widget> list = <Widget>[];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(final bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 13.0),
      height: 5,
      width: 60,
      decoration: BoxDecoration(
        color: isActive ? mainPrimaryColor : indicatorColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset(AssetsIcons.logo),
                SizedBox(
                  height:
                      310.0,
                  child: PageView(
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (final int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: const <Widget>[
                      OnBoardingWidget(
                        image: AssetsIcons.onBoardRocket,
                        title: 'Welcome',
                        subtitle: 'to Lana Express',
                        info:
                            'Search Truck and Expedited loads anytime anywere updated in real-time',
                      ),
                      OnBoardingWidget(
                        image: AssetsIcons.onBoardLocation,
                        title: 'We need your',
                        subtitle: 'location',
                        info: 'Give Lana Express access to your geolocation',
                      ),
                      OnBoardingWidget(
                        image: AssetsIcons.onBoardMail,
                        title: 'Photo library access',
                        info:
                            'Allow Lana Express to access photos and videos on this device',
                      ),
                      OnBoardingWidget(
                        image: AssetsIcons.onBoardRinging,
                        title: 'Allow notification',
                        info:
                            'Allow Lana Express to send you messages on this device',
                      ),
                    ],
                  ),
                ),
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage == 0
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: 56, left: 16, right: 16),
                        child: Column(
                          children: <Widget>[
                            BaseButton(
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              title: getStarted,
                            ),
                            const BaseTextButton(),
                          ],
                        ),
                      )
                    : Padding(
                        padding:
                            const EdgeInsets.only(top: 56, left: 16, right: 16),
                        child: Column(
                          children: <Widget>[
                            BaseButton(
                              onPressed: () async {
                                await pageIndex(_currentPage);
                                await _pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              title: allow,
                            ),
                            const BaseTextButton(),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pageIndex(final int index) async {
    switch (index) {
      case 1:
        RequestPermissionManager(PermissionType.whenInUseLocation)
            .onPermissionDenied(() {
          if (kDebugMode) {
            print('Location permission denied');
          }
        }).onPermissionGranted(() {
          if (kDebugMode) {
            print('Location permission granted');
          }
        }).onPermissionPermanentlyDenied(() {
          if (kDebugMode) {
            print('Location permission permanently denied');
          }
        }).onPermissionAlwaysGranted(() {
          if (kDebugMode) {
            print('Location permission permanently always');
          }
        })
        .execute();
        break;
      case 2:
        RequestPermissionManager(PermissionType.mediaLibrary).onPermissionDenied(() {
          if (kDebugMode) {
            print('storage permission denied');
          }
        }).onPermissionGranted(() {
          if (kDebugMode) {
            print('storage permission granted');
          }
        }).onPermissionPermanentlyDenied(() {
          if (kDebugMode) {
            print('storage permission permanently denied');
          }
        }).execute();
        break;
      case 3:
        RequestPermissionManager(PermissionType.notification)
            .onPermissionDenied(() {
          if (kDebugMode) {
            print('notification permission denied');
          }
        }).onPermissionGranted(() {
          if (kDebugMode) {
            print('notification permission granted');
          }
        }).onPermissionPermanentlyDenied(() {
          if (kDebugMode) {
            print('notification permission permanently denied');
          }
        }).execute();
        await PreferenceManager().setOnBoardingSeen(true);
        router.push(const gr.MainMobile());
        break;
      default:
    }
  }
}
