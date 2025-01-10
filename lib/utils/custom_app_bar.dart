import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/ui/main/main_viewmodel.dart';
import 'package:lanaexpress/utils/hold_widget/hold_view.dart';
import 'package:stacked/stacked.dart';

final class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBar({
    required this.count,
    super.key,
    this.showBackIcon = false,
    this.title,
  });
  final bool showBackIcon;
  final String? title;
  final double count;

  @override
  Widget build(final BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      onViewModelReady: (final MainViewModel viewModel) => viewModel.init(),
      builder: (
        final BuildContext context,
        final MainViewModel viewModel,
        final Widget? child,
      ) {
        return AppBar(
          title: Text(
            title ?? '',
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: 24),
          ),
          centerTitle: true,
          toolbarHeight: 104,
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.only(right: AppSizes.sizeM),
              child: HoldView(),
            ),
          ],
          automaticallyImplyLeading: showBackIcon,
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.copy(Size.fromHeight(count));
}
