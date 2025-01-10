import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/domain/models/loadboard_model.dart';
import 'package:lanaexpress/ui/loadboard/components/distance_box_widget.dart';
import 'package:lanaexpress/ui/loadboard/components/item_load_info_widget.dart';
import 'package:lanaexpress/ui/loadboard/components/item_local_widget.dart';
import 'package:lanaexpress/ui/loadboard/components/received_widget.dart';
import 'package:lanaexpress/ui/loadboard/loadboard_details.dart/loadboard_details_view.dart';
import 'package:lanaexpress/ui/loadboard/loadboard_screen.dart';
import 'package:lanaexpress/ui/loadboard/loadboard_viewmodel.dart';
import 'package:lanaexpress/utils/base_button.dart';
import 'package:lanaexpress/utils/date_formater.dart';
import 'package:lanaexpress/utils/date_received.dart';
import 'package:lanaexpress/utils/utils.dart';

final class LoadBoardBox extends StatefulWidget {
  const LoadBoardBox({
    required this.viewModel,
    required this.loadboard,
    super.key,
  });
  final LoadboardViewModel viewModel;
  final Loadboard loadboard;

  @override
  State<LoadBoardBox> createState() => _LoadBoardBoxState();
}

class _LoadBoardBoxState extends State<LoadBoardBox> {
  bool isExpanded = false;
  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: AppSizes.size20),
      child: Column(
        children: <Widget>[
          if (isExpanded)
            Container(
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
                        '#${widget.loadboard.name}',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(
                        height: 40,
                        width: 140,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.loadboard.driversList?.length,
                          itemBuilder:
                              (final BuildContext context, final int index) {
                            return DriverIdWidget(
                              iValue: widget.loadboard.driversList?[index],
                            );
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: const Row(
                          children: <Widget>[
                            Text(
                              'Hide',
                              style: TextStyle(
                                color: mainPrimaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Icon(
                              CupertinoIcons.chevron_down,
                              color: mainPrimaryColor,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(AppSizes.sizeM),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Received:',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                              color: dark,
                            ),
                      ),
                      Text(
                        '${timePassedParse(widget.loadboard.createdAt ?? '')} ago',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const Gap(10),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8),
                  //   child: Row(
                  //     children: [
                  //       const DotWidget(),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 30, bottom: 4),
                  //         child: DistanceBoxWidget(
                  //           color: distanseBoxColor,
                  //           title:
                  //               'Out: ${widget.loadboard.setDrivers(setDrivers ?? '')} mi',
                  //           height: 30,
                  //           width: 112,
                  //           fontSize: 16,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  ItemLocalWidget(
                    icon: AssetsIcons.icLocalFilledBlue,
                    city: combineLocation(
                          widget.loadboard.pkpCity,
                          widget.loadboard.pkpState,
                          widget.loadboard.pkpZip,
                        ) ??
                        '',
                    date: formatDateTime(widget.loadboard.pkpDate ?? ''),
                    width: 250,
                    paddingLeft: AppSizes.size12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.sizeSSM,
                    ),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.arrow_downward),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: AppSizes.size12, bottom: AppSizes.sizeXS,),
                          child: DistanceBoxWidget(
                            color: distanseBoxGreen,
                            title:
                                'Distance: ${widget.loadboard.distance} mi',
                            width: 154,
                            height: 28,
                            fontSize: AppSizes.sizeM,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ItemLocalWidget(
                    icon: AssetsIcons.greenTrackFill,
                    city: combineLocation(
                          widget.loadboard.delCity,
                          widget.loadboard.delState,
                          widget.loadboard.delZip,
                        ) ??
                        '',
                    date: formatDateTime(widget.loadboard.delDate ?? ''),
                    width: 250,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 26),
                    child: Text(
                      vehicalType(widget.loadboard.vehicleType) ?? '',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  const Gap(AppSizes.sizeM),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          if(widget.loadboard.totalWeight != 0)
                          ItemLoadInfoWidget(
                            title: widget.loadboard.totalWeight.toString(),
                            subtitle: 'lbs',
                          ),
                          if(widget.loadboard.dimLength != '0' && widget.loadboard.dimWidth != '0' && widget.loadboard.dimHeight != '0')
                          ItemLoadInfoWidget(
                            title:
                                '${widget.loadboard.dimLength ?? ''}*${widget.loadboard.dimWidth ?? ''}*${widget.loadboard.dimHeight ?? ''}',
                            subtitle: 'ln',
                          ),
                          if(widget.loadboard.totalPieceCount != 0)
                          ItemLoadInfoWidget(
                            title:
                                widget.loadboard.totalPieceCount.toString(),
                            subtitle: 'psc',
                          ),
                        ],
                      ),
                      Expanded(
                        child: BaseButton(
                          title: 'MAKE BID',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (final BuildContext context) {
                                  return LoadboardDetailsView(
                                    loadboard: widget.loadboard,
                                    viewModel: widget.viewModel,
                                  );
                                },
                              ),
                            );
                          },
                          height: 42,
                          width: 108,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: whiteColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: backgroundLight,
                borderRadius: AppBordersRadius.borderRadiusAllSSM,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ReceivedWidget(
                    number: '#${widget.loadboard.name}',
                    loadboard: widget.loadboard,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ItemLocalWidget(
                            icon: AssetsIcons.carbonLocationFilled,
                            city: combineLocation(
                                  widget.loadboard.pkpCity,
                                  widget.loadboard.pkpState,
                                  widget.loadboard.pkpZip,
                                ) ??
                                '',
                            date:
                                formatDateTime(widget.loadboard.pkpDate ?? ''),
                            width: MediaQuery.of(context).size.width * 0.6,
                          ),
                          const Gap(AppSizes.size6),
                          ItemLocalWidget(
                            icon: AssetsIcons.greenTruck,
                            city: combineLocation(
                                  widget.loadboard.delCity,
                                  widget.loadboard.delState,
                                  widget.loadboard.delZip,
                                ) ??
                                '',
                            date:
                                formatDateTime(widget.loadboard.delDate ?? ''),
                            width: MediaQuery.of(context).size.width * 0.6,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          DistanceBoxWidget(
                            title: '${widget.loadboard.distance} mi',
                            color: distanseBoxGreen,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                            child: const Row(
                              children: <Widget>[
                                Text(
                                  'More',
                                  style: TextStyle(
                                    color: mainPrimaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Icon(
                                  CupertinoIcons.chevron_down,
                                  color: mainPrimaryColor,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
