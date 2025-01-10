import 'package:flutter/material.dart';
import 'package:lanaexpress/ui/loadboard/filter_dialog/filter_dialog.dart';
import 'package:lanaexpress/ui/loadboard/loadboard_viewmodel.dart';
import 'package:stacked/stacked.dart';


class FilterDialogView extends StatelessWidget {
  const FilterDialogView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoadboardViewModel>.reactive(
        viewModelBuilder: () => LoadboardViewModel(),
        onViewModelReady: (viewModel) => viewModel.init(),
        builder: (context, viewModel, child) {
          return FilterDialog(
            viewModel: viewModel,
          );
        });
  }
}