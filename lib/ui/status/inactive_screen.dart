import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/statuses.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/ui/status/components/driver_drop_down.dart';
import 'package:lanaexpress/ui/status/components/set_date_dialog.dart';
import 'package:lanaexpress/ui/status/status_viewmodel.dart';
import 'package:lanaexpress/utils/base_button.dart';

final class InActiveStatusScreen extends StatelessWidget {
  const InActiveStatusScreen({
    required this.vm,
    super.key,
  });

  final StatusViewModel vm;

  @override
  Widget build(final BuildContext context) {
    return vm.isBusy
        ? const CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.sizeM),
            child: Center(
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        '#${vm.currentDriver?.currentLocation}',
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        vm.formatDate(vm.currentDriver?.timeOnPoint?.toString().split('.').first),
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        LoadsStatus.currentStatusText,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 90, bottom: 40),
                    child: Column(
                      children: <Widget>[
                        vm.currentDriver?.status == 0
                            ? Text(
                                AppStatuses.notAvailable,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(color: red),
                              )
                            : Text(
                                AppStatuses.active,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(color: green),
                              ),
                        const Gap(AppSizes.sizeM),
                        Text(
                          'To receive offers on loads, set it to active!',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            LoadsStatus.driver,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Gap(8),
                          DriverDropDownWidget(
                            model: vm,
                          ),
                        ],
                      ),
                      vm.currentDriver?.status == 1
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 32),
                              child: BaseButton(
                                title: LoadsStatus.inActive,
                                onPressed: () {
                                  vm.currentDriver?.status == 0
                                      ? vm.changeDriverStatus()
                                      : vm.driverStatusInActive();
                                },
                                color: grey1,
                              ),
                            )
                          : const Gap(AppSizes.sizeXL),
                      Text(
                        LoadsStatus.driverAnotherDate,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(AppSizes.sizeM),
                      BaseButton(
                        width: 200,
                        title: LoadsStatus.setAvailableDate,
                        color: grey2,
                        onPressed: () async {
                          await showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (final BuildContext context) {
                              return SetDateDialog(
                                viewModel: vm,
                              );
                            },
                          );
                        },
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
