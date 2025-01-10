import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/ui/main/main_viewmodel.dart';
import 'package:lanaexpress/utils/custom_app_bar.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class MainMobile extends StatefulWidget {
  const MainMobile({super.key});

  @override
  State<MainMobile> createState() => _MainMobileState();
}

class _MainMobileState extends State<MainMobile> {
  @override
  Widget build(final BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      onViewModelReady: (final MainViewModel vm) => vm.init(),
      builder: (final BuildContext context, final MainViewModel viewModel, final Widget? child) => 
      WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: (viewModel.blockedUnitsList?.isNotEmpty ?? false ) ? CustomAppBar(
            count: (((viewModel.blockedUnitsList?.length ?? 0) > 3
                        ? 3
                        : viewModel.blockedUnitsList?.length) ??
                    0) *
                36,
          ) : AppBar(
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: viewModel.pages.elementAt(viewModel.selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: backgroundNavBar,
            currentIndex: viewModel.selectedIndex,
            onTap: viewModel.onItemTapped,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            selectedLabelStyle:
                Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
            unselectedLabelStyle:
                Theme.of(context).bottomNavigationBarTheme.unselectedLabelStyle,
            items: viewModel.buildMobileNavItems(),
          ),
        ),
      ),
    );
  }
}
