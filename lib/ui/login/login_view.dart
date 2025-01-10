import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/ui/login/login_screen.dart';
import 'package:lanaexpress/ui/login/login_view_model.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(final BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onViewModelReady: (final LoginViewModel viewModel) {},
      builder: (final BuildContext context, final LoginViewModel viewModel, final Widget? child) => LoginScreen(vm: viewModel,),
    );
  }
}
