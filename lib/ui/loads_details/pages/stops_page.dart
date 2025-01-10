import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/ui/loadboard/components/item_local_widget.dart';
import 'package:lanaexpress/ui/loads_details/loads_details_viewmodel.dart';
import 'package:lanaexpress/ui/loads_details/pages/details_page.dart';
import 'package:lanaexpress/utils/date_formater.dart';
import 'package:lanaexpress/utils/utils.dart';

@RoutePage()
final class StopsPage extends StatelessWidget {
  const StopsPage({required this.viewModel, super.key});
  final LoadsDetailsViewModel viewModel;

  @override
  Widget build(final BuildContext context) {
    return Stack(
      children: <Widget>[
        (viewModel.currentLoads.stopsList?.isNotEmpty ?? false)
            ? ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.sizeM,
                  0,
                  AppSizes.sizeM,
                  0,
                ),
                itemCount: viewModel.currentLoads.stopsList?.length,
                itemBuilder: (final BuildContext context, final int index) =>
                    Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppSizes.sizeM,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: AppBordersRadius.borderRadiusAllSSM,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSizes.sizeS,
                        0,
                        0,
                        AppSizes.sizeM,
                      ),
                      child: ItemLocalWidget(
                        icon: AssetsIcons.icMapPin,
                        city: combineLocation(
                              viewModel.currentLoads.stopsList?[index].city,
                              viewModel.currentLoads.stopsList?[index].state,
                              viewModel.currentLoads.stopsList?[index].zip,
                            ) ??
                            '',
                        date: formatDateTime(
                          '${viewModel.currentLoads.stopsList?[index].date}',
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(AssetsIcons.loadsEmpty),
                    const Gap(55),
                    Text(
                      'No data for now',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.sizeM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                LoadStatusDropDown(
                  vm: viewModel,
                  loadsId: viewModel.currentLoads.id,
                ),
                const SizedBox(height: AppSizes.sizeXL),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
