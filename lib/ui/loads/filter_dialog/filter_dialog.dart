import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/domain/models/drivers_info.dart';
import 'package:lanaexpress/generated/router.dart';
import 'package:lanaexpress/ui/loadboard/filter_dialog/filter_dialog.dart';
import 'package:lanaexpress/ui/loads/loads_viewmodel.dart';
import 'package:lanaexpress/ui/status/components/city_selector.dart';
import 'package:lanaexpress/utils/base_button.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

final class FilterLoadsDialog extends StatefulWidget {
  const FilterLoadsDialog({
    required this.viewModel, super.key,
  });
  final LoadsViewModel viewModel;

  @override
  State<FilterLoadsDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterLoadsDialog> {
  String selectedDriver = '';

  @override
  Widget build(final BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: AppBordersRadius.borderRadiusAllSSM,
      ),
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
      elevation: 0,
      backgroundColor: whiteColor,
      content: SizedBox(
        width: 350,
        child: Form(
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      filter,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: black),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      CupertinoIcons.clear,
                      color: mainPrimaryColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.sizeM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Origin',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Gap(8),
                    CitySelectorTextField(
                      controller: widget.viewModel.originController,
                      mapController: widget.viewModel.originController,
                      itemClick: (final Prediction place) {
                        final String? selectedPlaceName = place
                            .description; // Отримайте назву місця або іншу інформацію про місце, яку ви хочете зберегти

                        // Збережіть вибране місце в контролері
                        widget.viewModel.originController.text =
                            selectedPlaceName ?? '';
                      },
                      icon: AssetsIcons.icTrace,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.sizeM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Destination',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Gap(8),
                    CitySelectorTextField(
                      controller: widget.viewModel.destinationController,
                      mapController: widget.viewModel.destinationController,
                      itemClick: (final Prediction place) {
                        final String? selectedDestination = place.description; // Отримайте назву місця або іншу інформацію про місце, яку ви хочете зберегти

                        // Збережіть вибране місце в контролері
                        widget.viewModel.destinationController.text =
                            selectedDestination ?? '';
                      },
                      icon: AssetsIcons.icRefresh,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.sizeM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Deadhead radius',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Gap(8),
                    TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 8.0,),
                        labelText: 'Miles',
                      ),
                      controller: widget.viewModel.distanceController,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.sizeM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      LoadsStatus.driver,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Gap(8),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: AppBordersRadius.borderRadiusAllXS,
                        border: Border.all(
                          color: backgroundBorder,
                        ),
                      ),
                      child: MultiSelectDropDown<DriversInfo>(
                        //controller: _controller,
                        borderRadius: 4,
                        clearIcon: const Icon(Icons.clear),
                        onOptionSelected:
                            (final List<ValueItem<DriversInfo>> options) {
                          widget.viewModel.driverIds = options
                              .map(
                                (final ValueItem<DriversInfo> option) =>
                                    option.value?.driverId ?? 0,
                              )
                              .toList();
                        },
                        options: widget.viewModel.statusViewModel.driverInfoList
                                ?.map<ValueItem<DriversInfo>>(
                                  (final DriversInfo driver) =>
                                      ValueItem<DriversInfo>(
                                    label: '${driver.name} ${driver.lastName}',
                                    value: driver,
                                  ),
                                )
                                .toList() ??
                            <ValueItem<DriversInfo>>[],
                        singleSelectItemStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: dark,
                        ),
                        chipConfig: const ChipConfig(
                          wrapType: WrapType.wrap,
                          backgroundColor: grey1,
                          radius: 4,
                        ),
                        optionTextStyle: const TextStyle(fontSize: 16),
                        selectedOptionIcon: const Icon(
                          Icons.check_circle,
                          color: Colors.pink,
                        ),
                        selectedOptionBackgroundColor: Colors.grey.shade300,
                        selectedOptionTextColor: Colors.blue,
                        dropdownMargin: 2,
                        onOptionRemoved:
                            (final int index, final ValueItem<DriversInfo> option) {
                          setState(() {
                            widget.viewModel.driverIds?.remove(option.value?.driverId);
                          });
                        },
                        optionBuilder: (
                          final BuildContext context,
                          final ValueItem<DriversInfo> valueItem,
                          final bool isSelected,
                        ) {
                          return ListTile(
                            leading: valueItem.value?.status == 1
                                ? Image.asset(
                                    AssetsIcons.icGreenDone,
                                  )
                                : Image.asset(
                                    AssetsIcons.icGreyDone,
                                  ),
                            title: Text(valueItem.label),
                            trailing: isSelected
                                ? const Icon(
                                    Icons.check_circle,
                                    color: green,
                                  )
                                : const Icon(Icons.radio_button_unchecked),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.sizeM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      LoadsStatus.truckType,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Gap(8),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: AppBordersRadius.borderRadiusAllXS,
                        border: Border.all(
                          color: backgroundBorder,
                        ),
                      ),
                      child: MultiSelectDropDown<TruckType>(
                        //controller: _controller,
                        hint: 'Select truck type',
                        borderRadius: 4,
                        clearIcon: const Icon(Icons.clear),
                        onOptionSelected:
                            (final List<ValueItem<TruckType>> options) {},
                        options: listTruckType
                            .map<ValueItem<TruckType>>(
                              (final TruckType truck) => ValueItem<TruckType>(
                                label: truck.name,
                                value: truck,
                              ),
                            )
                            .toList(),
                        singleSelectItemStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: dark,
                        ),
                        chipConfig: const ChipConfig(
                          wrapType: WrapType.wrap,
                          backgroundColor: grey1,
                          radius: 4,
                        ),
                        optionTextStyle: const TextStyle(fontSize: 16),
                        selectedOptionIcon: const Icon(
                          Icons.check_circle,
                          color: Colors.pink,
                        ),
                        selectedOptionBackgroundColor: Colors.grey.shade300,
                        selectedOptionTextColor: Colors.blue,
                        dropdownMargin: 2,
                        onOptionRemoved: (
                          final int index,
                          final ValueItem<TruckType> option,
                        ) {},
                        optionBuilder: (
                          final BuildContext context,
                          final ValueItem<TruckType> valueItem,
                          final bool isSelected,
                        ) {
                          return ListTile(
                            title: Text(valueItem.label),
                            trailing: isSelected
                                ? const Icon(
                                    Icons.check_circle,
                                    color: green,
                                  )
                                : const Icon(Icons.radio_button_unchecked),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.sizeM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Weight',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Gap(8),
                    TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 8.0,),
                        labelText: 'Pounds',
                      ),
                      controller: widget.viewModel.weightController,
                    ),
                  ],
                ),
              ),
              BaseButton(
                title: apply,
                onPressed: () {
                  //widget.viewModel.applyFilter();
                  AppRouter().maybePop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
