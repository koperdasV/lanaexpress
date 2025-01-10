import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/ui/splash/splash_screen.dart';

@RoutePage()
class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreen(),
    );
  }
}
