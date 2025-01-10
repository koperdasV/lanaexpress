import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/ui/profile/profile_screen.dart';
import 'package:lanaexpress/ui/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onViewModelReady: (viewModel) {},
      builder: (context, viewModel, child) {
        if (viewModel.isBusy) {
            return const CircularProgressIndicator();
          }
        return ProfileScreen(
          viewModel: viewModel,
        );
      },
    );
  }
}
