import 'package:flutter/material.dart';
import 'package:lanaexpress/ui/loads/filter_dialog/filter_dialog.dart';
import 'package:lanaexpress/ui/loads/loads_viewmodel.dart';
import 'package:stacked/stacked.dart';


class FilterDialogView extends StatelessWidget {
  const FilterDialogView({super.key});

  @override
  Widget build(final BuildContext context) {
    return ViewModelBuilder<LoadsViewModel>.reactive(
        viewModelBuilder: () => LoadsViewModel(),
        onViewModelReady: (final LoadsViewModel viewModel) { },
        builder: (final BuildContext context, final LoadsViewModel viewModel, final Widget? child) {
          return FilterLoadsDialog(
            viewModel: viewModel,
          );
        },);
  }
}