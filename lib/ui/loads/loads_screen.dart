import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/domain/models/loads_model.dart';
import 'package:lanaexpress/ui/loadboard/components/distance_box_widget.dart';
import 'package:lanaexpress/ui/loadboard/components/item_load_info_widget.dart';
import 'package:lanaexpress/ui/loadboard/components/item_local_widget.dart';
import 'package:lanaexpress/ui/loads/loads_viewmodel.dart';
import 'package:lanaexpress/ui/loads_details/loads_details_view.dart';
import 'package:lanaexpress/utils/base_button.dart';
import 'package:lanaexpress/utils/date_formater.dart';
import 'package:lanaexpress/utils/dot_widget.dart';
import 'package:lanaexpress/utils/filter_loads_button.dart';
import 'package:lanaexpress/utils/utils.dart';

class LoadsScreen extends StatelessWidget {
  const LoadsScreen({required this.vm, super.key});
  final LoadsViewModel vm;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  NavBarTitles.loads,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                FilterLoadsButton(
                  viewModel: vm,
                ),
              ],
            ),
            vm.loads.isNotEmpty
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppSizes.size12),
                      child: ListView.builder(
                        itemCount: vm.loads.length,
                        itemBuilder:
                            (final BuildContext context, final int index) =>
                                LoadsBoxWidget(
                          loads: vm.loads[index],
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(AssetsIcons.loadsEmpty),
                        const Gap(55),
                        Text(
                          'No data for now',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Gap(AppSizes.sizeM),
                        BaseButton(
                          title: 'Refresh',
                          onPressed: () {
                            //vm.refreshLoadboard();
                          },
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class LoadsBoxWidget extends StatelessWidget {
  const LoadsBoxWidget({
    required this.loads,
    super.key,
  });
  final LoadsResponse loads;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22, top: AppSizes.sizeM),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: const BoxDecoration(
          color: backgroundLight,
          borderRadius: AppBordersRadius.borderRadiusAllSSM,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '#${loads.name}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  "Price: \$${loads.loadPrice}",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: dark,
                      ),
                ),
              ],
            ),
            const Gap(16),
            Text(
              'Vehicle: #${loads.unitId}',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: dark,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    AssetsIcons.icUser,
                    color: dark,
                  ),
                  const Gap(5),
                  Text(
                    loads.driverFullInfo?.name.toString() ?? '',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.sizeS),
              child: Row(
                children: <Widget>[
                  const DotWidget(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 26, bottom: AppSizes.sizeXS),
                    child: DistanceBoxWidget(
                      color: distanseBoxColor,
                      title: 'Out: ${loads.distanceLeft ?? 0} mi',
                      height: 29,
                      width: 112,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ItemLocalWidget(
              icon: AssetsIcons.icLocalFilledBlue,
              city: combineLocation(
                    loads.pkpCity,
                    loads.pkpState,
                    loads.pkpZip,
                  ) ??
                  '',
              date: formatDateTime(loads.pkpDate.toString()),
              paddingLeft: AppSizes.size12,
            ),
            Row(
              children: <Widget>[
                const Icon(Icons.arrow_downward),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppSizes.size12, bottom: AppSizes.sizeXS),
                  child: DistanceBoxWidget(
                    color: distanseBoxGreen,
                    title: 'Distance: ${loads.distance ?? 0} mi',
                    width: 154,
                    height: 29,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            ItemLocalWidget(
              icon: AssetsIcons.greenTrackFill,
              city: combineLocation(
                    loads.delCity,
                    loads.delState,
                    loads.delZip,
                  ) ??
                  '',
              date: formatDateTime(loads.delDate.toString()),
            ),
            const Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Row(
                  children: <Widget>[
                    ItemLoadInfoWidget(
                      title: '20', //TODO
                      subtitle: 'lbs',
                    ),
                    ItemLoadInfoWidget(
                      title: '1',
                      subtitle: 'psc',
                    ),
                  ],
                ),
                BaseButton(
                  title: 'VIEW LOAD',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<dynamic>(
                        builder: (final BuildContext context) =>
                            LoadsDetailsView(
                          loadsId: loads.id!,
                        ),
                      ),
                    );
                  },
                  height: 42,
                  width: 109,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: whiteColor,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
