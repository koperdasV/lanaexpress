import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/ui/loads_details/loads_details_viewmodel.dart';
import 'package:lanaexpress/ui/loads_details/pages/details_page.dart';
import 'package:lanaexpress/ui/loads_details/pages/documents_page.dart';
import 'package:lanaexpress/ui/loads_details/pages/map_page.dart';
import 'package:lanaexpress/ui/loads_details/pages/stops_page.dart';
import 'package:provider/provider.dart';

@RoutePage()
final class LoadsNavigationBar extends StatefulWidget {
  const LoadsNavigationBar({
    super.key,
  });

  @override
  State<LoadsNavigationBar> createState() => _LoadsNavigationBarState();
}

class _LoadsNavigationBarState extends State<LoadsNavigationBar> with SingleTickerProviderStateMixin  {
  late final LoadsDetailsViewModel model =
      Provider.of<LoadsDetailsViewModel>(context);
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController.index == 3) {
      model.getAllDocuments();
    }
  }

  @override
  Widget build(final BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.sizeM),
              child: Text(
                'Load: #${model.currentLoads.id ?? ''}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: AppSizes.sizeL,
                bottom: AppSizes.sizeXL,
                left: AppSizes.sizeM,
                right: AppSizes.sizeM,
              ),
              child: Container(
                height: 44,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: mainSecondaryColor,
                  borderRadius: AppBordersRadius.borderRadiusAllXS,
                  border: Border(),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelPadding: EdgeInsets.zero,
                  tabs: <Widget>[
                    Tab(
                      child: buildTabBarText('Details'),
                    ),
                    //if (model.currentLoads.stopsList?.isNotEmpty ?? false)
                      Tab(
                        child: buildTabBarText('Stops'),
                      ),
                    Tab(
                      child: buildTabBarText('Map'),
                    ),
                    Tab(
                      child: buildTabBarText('Documents'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: model.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : TabBarView(
                    controller: _tabController,
                      children: <Widget>[
                        DetailsPage(
                          viewModel: model,
                        ),
                        //if (model.currentLoads.stopsList?.isNotEmpty ?? false)
                          StopsPage(
                            viewModel: model,
                          ),
                        MapPage(
                          viewModel: model,
                        ),
                        DocumentsPage(
                          viewModel: model,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  FittedBox buildTabBarText(final String text) {
    return FittedBox(
      child: Text(
        text,
        style: Theme.of(context).tabBarTheme.unselectedLabelStyle,
      ),
    );
  }
}
