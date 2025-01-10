import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl/intl.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/constants/statuses.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/ui/status/components/city_selector.dart';
import 'package:lanaexpress/ui/status/status_viewmodel.dart';
import 'package:lanaexpress/utils/base_button.dart';

class ActiveStatusScreen extends StatelessWidget {
  const ActiveStatusScreen({
    required this.vm,
    super.key,
  });

  final StatusViewModel vm;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.sizeM),
      child: Center(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  '#${vm.driverInfoList?.first.currentLocation}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  LoadsStatus.currentStatusText,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppSizes.size40),
              child: Column(
                children: <Widget>[
                  Text(
                    AppStatuses.active,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: green),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSizes.sizeM),
                    child: Text(
                      vm.userInfo?.address.toString() ?? '',
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    'To stop working, change the status to inactive',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(AppSizes.size40),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.sizeM,
                      vertical: AppSizes.sizeL,
                    ),
                    decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: AppBordersRadius.borderRadiusAllSSM,
                    ),
                    child: Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            LoadsStatus.driverAnotherDate,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: black, letterSpacing: 0.015),
                            textAlign: TextAlign.center,
                          ),
                          const Gap(32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        date,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      const Gap(8),
                                      TextFormField(
                                        controller: vm.dateController,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 15.0,
                                            horizontal: 8.0,
                                          ),
                                        ),
                                        readOnly: true,
                                        onTap: () {
                                          showCupertinoModalPopup(
                                            context: context,
                                            builder:
                                                (final BuildContext context) {
                                              return Container(
                                                height: 200,
                                                color: Colors.white,
                                                child: CupertinoDatePicker(
                                                  mode: CupertinoDatePickerMode
                                                      .date,
                                                  onDateTimeChanged:
                                                      (final DateTime newDate) {
                                                    vm.dateController.text =
                                                        DateFormat('dd.MM.yy')
                                                            .format(newDate);
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(AppSizes.sizeM),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        time,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      const Gap(8),
                                      TextFormField(
                                        controller: vm.timeController,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 15.0,
                                            horizontal: 8.0,
                                          ),
                                        ),
                                        readOnly: true,
                                        onTap: () {
                                          showCupertinoModalPopup(
                                            context: context,
                                            builder:
                                                (final BuildContext context) {
                                              return Container(
                                                height: 200,
                                                color: Colors.white,
                                                child: CupertinoDatePicker(
                                                  mode: CupertinoDatePickerMode
                                                      .time,
                                                  onDateTimeChanged:
                                                      (final DateTime newTime) {
                                                    vm.timeController.text =
                                                        TimeOfDay.fromDateTime(
                                                      newTime,
                                                    ).format(context);
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(AppSizes.sizeM),
                          CitySelectorTextField(
                            controller: vm.originController,
                            mapController: vm.originController,
                            itemClick: (final Prediction place) {
                              final String? selectedPlaceName =
                                  place.description;
                              vm.originController.text =
                                  selectedPlaceName ?? '';
                            },
                            icon: AssetsIcons.icTrace,
                          ),
                          const Gap(24),
                          BaseButton(
                            title: apply,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
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