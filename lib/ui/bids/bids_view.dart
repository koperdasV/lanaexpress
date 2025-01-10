import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/ui/bids/bids_screen.dart';
import 'package:lanaexpress/ui/bids/bids_viewmodel.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class BidsView extends StatelessWidget {
  const BidsView({super.key});

  @override
  Widget build(final BuildContext context) {
    return ViewModelBuilder<BidsViewModel>.reactive(
      viewModelBuilder: () => BidsViewModel(),
      onViewModelReady: (final BidsViewModel viewModel) => viewModel.init(),
      builder: (final BuildContext context, final BidsViewModel viewModel, final Widget? child) {
        
        return  BidsScreen(
          viewModel: viewModel,
        );
      },
    );
  }
}