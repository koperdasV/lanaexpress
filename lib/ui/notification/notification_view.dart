import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/ui/notification/notification_screen.dart';
import 'package:lanaexpress/ui/notification/notification_viewmodel.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(final BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
      viewModelBuilder: () => NotificationViewModel(),
      onViewModelReady: (final NotificationViewModel viewModel) => viewModel.init(),
      builder: (final BuildContext context, final NotificationViewModel viewModel, final Widget? child) {
        
        return  NotificationScreen(
          viewModel: viewModel,
        );
      },
    );
  }
}