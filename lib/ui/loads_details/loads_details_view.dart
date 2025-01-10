import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/ui/loads_details/loads_details.dart';
import 'package:lanaexpress/ui/loads_details/loads_details_viewmodel.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
final class LoadsDetailsView extends StatelessWidget {
  const LoadsDetailsView({required this.loadsId, super.key});
  final int loadsId;

  @override
  Widget build(final BuildContext context) {
    return ViewModelBuilder<LoadsDetailsViewModel>.reactive(
      viewModelBuilder: () => LoadsDetailsViewModel(),
      onViewModelReady: (final LoadsDetailsViewModel viewModel) async {
        await viewModel.getLoadById(loadsId);
        await viewModel.init();
      },
      builder: (final BuildContext context, final LoadsDetailsViewModel viewModel, final Widget? child) {
        return const LoadsNavigationBar();
      },
    );
  }
}
