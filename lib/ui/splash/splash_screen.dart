import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/ui/splash/splash_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (BuildContext context, SplashViewModel viewModel, Widget? child) {
        return Center(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.sizeM),
          child: Image.asset(AssetsIcons.splashLogo),
        ));
      },
    );
  }
}