import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/ui/status/components/citi_map_status_screen.dart';
import 'package:lanaexpress/ui/status/components/date_picker.dart';
import 'package:lanaexpress/ui/status/components/time_picker.dart';
import 'package:lanaexpress/ui/status/status_viewmodel.dart';
import 'package:lanaexpress/utils/base_button.dart';
import 'package:lanaexpress/utils/base_outlined_button.dart';

final class SetDateDialog extends StatefulWidget {
  const SetDateDialog({required this.viewModel, super.key, this.lat, this.lng});
  final StatusViewModel viewModel;
  final double? lat;
  final double? lng;

  @override
  State<SetDateDialog> createState() => _SetDateDialogState();
}

class _SetDateDialogState extends State<SetDateDialog> {
  @override
  void initState() {
    super.initState();
    final DateTime now = DateTime.now();
    widget.viewModel.dateController.text =
        '${now.month}/${now.day}/${now.year}';
    widget.viewModel.timeController.text =
        '${now.hour}:${now.minute}'; // Форматуйте час як потрібно
  }

  @override
  Widget build(final BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: AppBordersRadius.borderRadiusAllSSM,
      ),
      backgroundColor: whiteColor,
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
      content: SizedBox(
        width: 350,
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      LoadsStatus.setAvailableDate,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  DataPicker(viewModel: widget.viewModel),
                  const Gap(AppSizes.sizeM),
                  TimePicker(viewModel: widget.viewModel),
                ],
              ),
              const Gap(AppSizes.sizeM),
              CitySelectorStatusScreen(
                controller: widget.viewModel.originController,
                mapController: widget.viewModel.originController,
                itemClick: (final Prediction place) {
                  final String? selectedPlaceName = place.description;
                  widget.viewModel.originController.text =
                      selectedPlaceName ?? '';
                },
                getPlaceDetailWithLatLng: (final Prediction prediction) {
                  widget.viewModel.selectedLatitude =
                      double.parse(prediction.lat.toString());
                  widget.viewModel.selectedLongitude =
                      double.parse(prediction.lng.toString());
                  if (kDebugMode) {
                    print("Place-------${prediction.lat}----------");
                    print("Place-------${prediction.lng}----------");
                  }
                },
                icon: AssetsIcons.icTrace,
                viewModel: widget.viewModel,
              ),
              const Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: BaseOutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.viewModel.originController.clear();
                        widget.viewModel.timeController.clear();
                        widget.viewModel.dateController.clear();
                      },
                      title: cancel,
                      height: 52,
                    ),
                  ),
                  const Gap(AppSizes.sizeS),
                  Expanded(
                    child: BaseButton(
                      title: LoadsStatus.setActive,
                      onPressed: () async {
                        await widget.viewModel.updateLocation();
                        widget.viewModel.originController.clear();
                        widget.viewModel.changeDriverStatus();
                        widget.viewModel.currentDriver?.status == 0
                            ? widget.viewModel.changeDriverStatus()
                            : widget.viewModel.driverStatusInActive();
                      },
                      color: mainPrimaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
