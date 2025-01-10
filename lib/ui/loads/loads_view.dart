import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/ui/loads/loads_screen.dart';
import 'package:lanaexpress/ui/loads/loads_viewmodel.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class LoadsView extends StatelessWidget {
  const LoadsView({super.key});

  @override
  Widget build(final BuildContext context) {
    return ViewModelBuilder<LoadsViewModel>.reactive(
        viewModelBuilder: () => LoadsViewModel(),
        onViewModelReady: (final LoadsViewModel viewModel) => viewModel.init(),
        builder: (final BuildContext context, final LoadsViewModel viewModel, final Widget? child) {
          if (viewModel.isBusy) {
            return const CircularProgressIndicator();
          }
          return LoadsScreen(
            vm: viewModel,
          );
        },);
  }
}
