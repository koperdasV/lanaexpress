import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/ui/loadboard/loadboard_screen.dart';
import 'package:lanaexpress/ui/loadboard/loadboard_viewmodel.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class LoadBoardView extends StatelessWidget {
  const LoadBoardView({super.key});

  @override
  Widget build(final BuildContext context) {
    return ViewModelBuilder<LoadboardViewModel>.reactive(
        viewModelBuilder: () => LoadboardViewModel(),
        onViewModelReady: (final LoadboardViewModel viewModel) => viewModel.init(),
        builder: (final BuildContext context, final LoadboardViewModel viewModel, final Widget? child) {
          if (viewModel.isBusy) {
            return const CircularProgressIndicator();
          }
          return LoadBoardScreen(
            vm: viewModel,
          );
        },);
  }
}
