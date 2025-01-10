import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/ui/success/success_screen.dart';
import 'package:lanaexpress/ui/success/success_viewmodel.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SuccessViewModel>.reactive(
      viewModelBuilder: () => SuccessViewModel(),
      onViewModelReady: (viewModel) {},
      builder:
          (BuildContext context, SuccessViewModel viewModel, Widget? child) {
        return const SuccessScreen();
      },
    );
  }
}
