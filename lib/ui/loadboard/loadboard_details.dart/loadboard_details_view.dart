import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/domain/models/drivers_info.dart';
import 'package:lanaexpress/domain/models/loadboard_model.dart';
import 'package:lanaexpress/generated/router.dart';
import 'package:lanaexpress/ui/loadboard/components/distance_box_widget.dart';
import 'package:lanaexpress/ui/loadboard/components/item_load_info_widget.dart';
import 'package:lanaexpress/ui/loadboard/components/item_local_widget.dart';
import 'package:lanaexpress/ui/loadboard/loadboard_details.dart/components/note_box.dart';
import 'package:lanaexpress/ui/loadboard/loadboard_details.dart/components/text_item_place_dialog.dart';
import 'package:lanaexpress/ui/loadboard/loadboard_details.dart/maps_screen.dart';
import 'package:lanaexpress/ui/loadboard/loadboard_viewmodel.dart';
import 'package:lanaexpress/ui/loads_details/pages/details_page.dart';
import 'package:lanaexpress/utils/base_button.dart';
import 'package:lanaexpress/utils/date_formater.dart';
import 'package:lanaexpress/utils/date_received.dart';
import 'package:lanaexpress/utils/title_widget.dart';
import 'package:lanaexpress/utils/utils.dart';

final class LoadboardDetailsView extends StatefulWidget {
  const LoadboardDetailsView({
    required this.loadboard,
    required this.viewModel,
    super.key,
  });
  final LoadboardViewModel viewModel;
  final Loadboard? loadboard;

  @override
  State<LoadboardDetailsView> createState() => _LoadboardDetailsViewState();
}

class _LoadboardDetailsViewState extends State<LoadboardDetailsView> {
  DriversInfo? selectedDriver;
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.sizeM),
        child: ListView(
          children: <Widget>[
            TitleWidget(title: 'Load: #${widget.loadboard?.name}'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSizes.size30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    received,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    '${timePassedParse(widget.loadboard?.createdAt ?? '')} ago',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 14, bottom: 20),
              decoration: const BoxDecoration(
                color: backgroundLight,
                borderRadius: AppBordersRadius.borderRadiusAllSSM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ItemLocalWidget(
                    icon: AssetsIcons.icLocalFilledBlue,
                    city: combineLocation(
                          widget.loadboard?.pkpCity,
                          widget.loadboard?.pkpState,
                          widget.loadboard?.pkpZip,
                        ) ??
                        '',
                    date: formatDateTime(widget.loadboard?.pkpDate ?? ''),
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18, bottom: 6),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.arrow_downward),
                        Padding(
                          padding: const EdgeInsets.only(left: 14, bottom: 4),
                          child: DistanceBoxWidget(
                            color: distanseBoxGreen,
                            title: 'Distance: ${widget.loadboard?.distance} mi',
                            width: 154,
                            height: 29,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ItemLocalWidget(
                    icon: AssetsIcons.greenTrackFill,
                    city: combineLocation(
                          widget.loadboard?.delCity,
                          widget.loadboard?.delState,
                          widget.loadboard?.delZip,
                        ) ??
                        '',
                    date: formatDateTime(widget.loadboard?.pkpDate ?? ''),
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 26),
                    child: Text(
                      vehicalType(widget.loadboard?.vehicleType) ?? '',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  const Gap(16),
                  Row(
                    children: <Widget>[
                      ItemLoadInfoWidget(
                        title: widget.loadboard?.totalWeight.toString() ?? '',
                        subtitle: 'lbs',
                      ),
                      ItemLoadInfoWidget(
                        title:
                            '${widget.loadboard?.dimLength ?? ''}*${widget.loadboard?.dimWidth ?? ''}*${widget.loadboard?.dimHeight ?? ''}',
                        subtitle: 'ln',
                      ),
                      ItemLoadInfoWidget(
                        title:
                            widget.loadboard?.totalPieceCount.toString() ?? '',
                        subtitle: 'psc',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const TypeTransportationBox(),
            NoteBox(
              loadboard: widget.loadboard,
            ),
            MapsWidget(
              loadboards: widget.loadboard,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSizes.size30),
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<DriversInfo?>(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        value: widget.viewModel.currentDriver,
                        dropdownColor: whiteColor,
                        iconEnabledColor: Colors.blue,
                        isExpanded: true,
                        onTap: () => Get.focusScope?.unfocus(),
                        icon: const Icon(CupertinoIcons.chevron_down),
                        items: widget.viewModel.statusViewModel.driverInfoList
                            ?.where((final DriversInfo driver) =>
                                driver.status == 1,) // Фільтруємо список
                            .map<DropdownMenuItem<DriversInfo?>>(
                              (final DriversInfo? driver) =>
                                  DropdownMenuItem<DriversInfo?>(
                                value: driver,
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Image.asset(AssetsIcons
                                          .icGreenDone,),
                                    ),
                                    Text(
                                      '#${driver?.unitId} ${driver?.name} ${driver?.lastName}',
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
                          setState(() {
                            widget.viewModel.currentDriver = value;
                            selectedDriver = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PalaceBidWidget(
              loadboard: widget.loadboard,
              selectDriver: selectedDriver,
              viewModel: widget.viewModel,
            ),
          ],
        ),
      ),
    );
  }
}

class PalaceBidWidget extends StatefulWidget {
  const PalaceBidWidget({
    required this.selectDriver,
    required this.viewModel,
    super.key,
    this.loadboard,
  });
  final Loadboard? loadboard;
  final DriversInfo? selectDriver;
  final LoadboardViewModel viewModel;

  @override
  State<PalaceBidWidget> createState() => _PalaceBidWidgetState();
}

class _PalaceBidWidgetState extends State<PalaceBidWidget> {
  late final TextEditingController sumController = TextEditingController();
  late final TextEditingController pricePerMileController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    sumController.addListener(calculatePricePerMile);
  }

  void calculatePricePerMile() {
    if (sumController.text.isNotEmpty) {
      final double sum = double.tryParse(sumController.text) ?? 0;
      final double distance =
          double.parse(widget.loadboard?.distance.toString() ?? '');
      final double pricePerMile = sum / distance;

      final TextEditingValue newValue =
          TextEditingValue(text: pricePerMile.toStringAsFixed(3));

      pricePerMileController.value = newValue;
    } else {
      pricePerMileController.text = '';
    }
  }

  @override
  void dispose() {
    sumController.dispose();
    pricePerMileController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.sizeXL),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.sizeM),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Palace Bid',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                DistanceBoxWidget(
                  color: distanseBoxGreen,
                  title: '${widget.loadboard?.distance} mi',
                ),

                // Row(
                //   children: <Widget>[
                //     const DistanceBoxWidget(
                //         color: distanseBoxColor, title: '105 mi',),
                //     const Gap(AppSizes.sizeS),
                //     DistanceBoxWidget(
                //         color: distanseBoxGreen,
                //         title: '${widget.loadboard?.distance} mi',),
                //   ],
                // ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Your price',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: AppSizes.size12,
                          horizontal: AppSizes.sizeS,
                        ),
                      ),
                      controller: sumController,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              const Gap(AppSizes.sizeS),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      r'$ / mi:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextFormField(
                      readOnly: true,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: AppSizes.size12,
                          horizontal: AppSizes.sizeS,
                        ),
                      ),
                      controller: pricePerMileController,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              const Gap(AppSizes.sizeS),
              BaseButton(
                width: 116,
                title: 'SEND',
                onPressed: () async {
                  if (sumController.text.isNotEmpty ||
                      pricePerMileController.text.isNotEmpty) {
                    await Future.wait(<Future<dynamic>>[
                      widget.viewModel.setDriverBid(widget.loadboard,
                          sumController.text, widget.viewModel,),
                      showDialog(
                        context: context,
                        builder: (final BuildContext context) {
                          return SendBidDialog(
                            loadboard: widget.loadboard,
                            sumText: sumController.text,
                            pricePerMileText: pricePerMileController.text,
                            selectedDriver: widget.selectDriver,
                            viewModel: widget.viewModel,
                          );
                        },
                      ),
                    ]);
                  } else {
                    toastCheck('Amount and price per mile cannot be empty');
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SendBidDialog extends StatefulWidget {
  const SendBidDialog({
    required this.loadboard,
    required this.viewModel,
    super.key,
    this.sumText,
    this.pricePerMileText,
    this.selectedDriver,
  });

  final Loadboard? loadboard;
  final LoadboardViewModel? viewModel;
  final String? sumText;
  final String? pricePerMileText;
  final DriversInfo? selectedDriver;

  @override
  State<SendBidDialog> createState() => _SendBidDialogState();
}

class _SendBidDialogState extends State<SendBidDialog> {
  @override
  Widget build(final BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: AppBordersRadius.borderRadiusAllSSM,
      ),
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.sizeM,
        vertical: AppSizes.sizeL,
      ),
      content: SizedBox(
        width: 350,
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      youPlace,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: black),
                      textAlign: TextAlign.center,
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
              TextItemPlaceDialog(
                title: PlaceDialogTitles.origin,
                info: combineLocation(
                      widget.loadboard?.pkpCity,
                      widget.loadboard?.pkpState,
                      widget.loadboard?.pkpZip,
                    ) ??
                    '',
              ),
              TextItemPlaceDialog(
                title: PlaceDialogTitles.destanation,
                info: combineLocation(
                      widget.loadboard?.delCity,
                      widget.loadboard?.delState,
                      widget.loadboard?.delZip,
                    ) ??
                    '',
              ),
              TextItemPlaceDialog(
                title: PlaceDialogTitles.price,
                info: "\$ ${widget.sumText}  \$/mi: ${widget.pricePerMileText}",
              ),
              TextItemPlaceDialog(
                title: PlaceDialogTitles.driver,
                info: widget.selectedDriver?.name ?? '',
              ),
              TextItemPlaceDialog(
                title: PlaceDialogTitles.truckType,
                info: vehicalType(widget.loadboard?.vehicleType) ?? '',
              ),
              const Gap(24),
              BaseButton(
                title: apply,
                onPressed: () {
                  widget.viewModel?.applyBid();
                },
              ),
              const Gap(AppSizes.sizeM),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    router.maybePop();
                  },
                  style: ButtonStyle(
                    padding:
                        const WidgetStatePropertyAll<EdgeInsetsGeometry?>(
                            EdgeInsets.all(10),),
                    backgroundColor:
                        const WidgetStatePropertyAll<Color?>(btnFilter),
                    shape: WidgetStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: AppBordersRadius.borderRadiusAllS,
                        side: BorderSide(
                          color: mainPrimaryColor,
                          width: 15,
                        ),
                      ),
                    ),
                    side: WidgetStateProperty.all(
                      const BorderSide(
                        color: mainPrimaryColor,
                      ),
                    ),
                  ),
                  child: Text(
                    cancel,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
