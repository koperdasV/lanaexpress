import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/ui/status/status_screen.dart';
import 'package:lanaexpress/ui/status/status_viewmodel.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class StatusView extends StatelessWidget {
  const StatusView({super.key});

  @override
  Widget build(final BuildContext context) {
    return ViewModelBuilder<StatusViewModel>.reactive(
      viewModelBuilder: () => StatusViewModel(),
      onViewModelReady: (final StatusViewModel viewModel) => viewModel.init(),
      builder: (final BuildContext context, final StatusViewModel viewModel, final Widget? child) {
        if (viewModel.isBusy) {
            return const CircularProgressIndicator();
          }
        return StatusScreen(
          vm: viewModel,
        );
      },
    );
  }
}
