import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/domain/models/drivers_info.dart';
import 'package:lanaexpress/ui/status/status_viewmodel.dart';

final class DriverDropDownWidget extends StatefulWidget {
  const DriverDropDownWidget({
    required this.model,
    super.key,
  });
  final StatusViewModel model;

  @override
  State<DriverDropDownWidget> createState() => _DriverDropDownWidgetState();
}

class _DriverDropDownWidgetState extends State<DriverDropDownWidget> {
  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.size20,
        vertical: AppSizes.size6,
      ),
      decoration: BoxDecoration(
        borderRadius: AppBordersRadius.borderRadiusAllXS,
        color: whiteColor,
        border: Border.all(color: backgroundBorder),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<DriversInfo>(
          value: widget.model.currentDriver,
          dropdownColor: whiteColor,
          iconEnabledColor: Colors.blue,
          isExpanded: true,
          icon: const Icon(CupertinoIcons.chevron_down),
          items: widget.model.driverInfoList
              ?.map<DropdownMenuItem<DriversInfo>>(
                (final DriversInfo driver) => DropdownMenuItem<DriversInfo>(
                  value: driver,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: AppSizes.sizeSSM),
                        child: driver.status == 1 ? Image.asset(AssetsIcons.icGreenDone) : Image.asset(AssetsIcons.icGreyDone),
                      ),
                      Text(
                        '#${driver.unitId} ${driver.name} ${driver.lastName}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: grey),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          onChanged: (final DriversInfo? value) {
            widget.model.selectedDriver(value);
          },
        ),
      ),
    );
  }
}
