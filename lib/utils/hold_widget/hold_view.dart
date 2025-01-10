import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/ui/main/main_viewmodel.dart';
import 'package:lanaexpress/utils/hold_widget/hold_widget.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class HoldView extends StatelessWidget {
  const HoldView({super.key});

  @override
  Widget build(final BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      onViewModelReady: (final MainViewModel viewModel) => viewModel.init(),
      builder: (final BuildContext context, final MainViewModel viewModel, final Widget? child) {
        return HoldWidget(
          vm: viewModel,
        );
      },
    );
  }
}
