import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/domain/models/loads_model.dart';
import 'package:lanaexpress/domain/models/loads_statuses.dart';
import 'package:lanaexpress/ui/loadboard/components/distance_box_widget.dart';
import 'package:lanaexpress/ui/loadboard/components/item_load_info_widget.dart';
import 'package:lanaexpress/ui/loadboard/components/item_local_widget.dart';
import 'package:lanaexpress/ui/loads_details/loads_details_viewmodel.dart';
import 'package:lanaexpress/utils/date_formater.dart';
import 'package:lanaexpress/utils/date_received.dart';
import 'package:lanaexpress/utils/utils.dart';

@RoutePage()
class DetailsPage extends StatelessWidget {
  const DetailsPage({
    required this.viewModel,
    final Key? key,
  }) : super(key: key);

  final LoadsDetailsViewModel viewModel;

  @override
  Widget build(final BuildContext context) {
    return Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.sizeM,
                0,
                AppSizes.sizeM,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Received:',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        '${timePassedParse(viewModel.currentLoads.createdAt ?? '')} ago',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'For vehicle: #${viewModel.currentLoads.unitId}',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: dark,
                        ),
                  ),
                  const SizedBox(height: AppSizes.sizeM),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppSizes.size40,
                    ),
                    child: Container(
                      height: 48,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: AppBordersRadius.borderRadiusAllXS,
                        border: Border.all(color: backgroundBorder),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: AppSizes.sizeSSM),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              AssetsIcons.icUser,
                              color: dark,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              viewModel.currentLoads.driverFullInfo?.name ?? '',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  LoadboardBox(
                    loadsResponse: viewModel.currentLoads,
                  ),
                  const TypeTransportationBox(),
                  const SizedBox(height: AppSizes.sizeL),
                  const SizedBox(height: 75),
                ],
              ),
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


class TypeTransportationBox extends StatelessWidget {
  const TypeTransportationBox({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: AppSizes.sizeXL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TypeTransportation(
            icon: AssetsIcons.icHazardous,
            type: 'Hazardous',
            status: 'NO',
          ),
          TypeTransportation(
            icon: AssetsIcons.icStackable,
            type: 'Stackable',
            status: 'NO',
          ),
          TypeTransportation(
            icon: AssetsIcons.icFastLoad,
            type: 'Fast Load',
            status: 'NO',
          ),
          TypeTransportation(
            icon: AssetsIcons.icDockLevel,
            type: 'Dock level',
            status: 'NO',
          ),
        ],
      ),
    );
  }
}

class LoadboardBox extends StatelessWidget {

  const LoadboardBox({
    super.key,
    this.loadsResponse,
  });
  final LoadsResponse? loadsResponse;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(left: AppSizes.size12, bottom: AppSizes.size20),
      decoration: const BoxDecoration(
        color: backgroundLight,
        borderRadius: AppBordersRadius.borderRadiusAllSSM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ItemLocalWidget(
            icon: AssetsIcons.icLocalFilledBlue,
            city: combineLocation(loadsResponse?.pkpCity,
                    loadsResponse?.pkpState, loadsResponse?.pkpZip,) ??
                '',
            date: formatDateTime(loadsResponse?.pkpDate.toString()),
            paddingLeft: AppSizes.size12,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: AppSizes.size6),
            child: Row(
              children: <Widget>[
                const Icon(Icons.arrow_downward),
                Padding(
                  padding:
                      const EdgeInsets.only(left: AppSizes.size12, bottom: AppSizes.sizeXS),
                  child: DistanceBoxWidget(
                    color: distanseBoxGreen,
                    title: 'Distance: ${loadsResponse?.distance} mi',
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
            city: combineLocation(loadsResponse?.delCity,
                    loadsResponse?.delState, loadsResponse?.delZip,) ??
                '',
            date: formatDateTime(loadsResponse?.delDate.toString()),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 26),
            child: Text(
              vehicalType(loadsResponse?.vehicleType) ?? '',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          const Gap(AppSizes.sizeM),
          const Row(
            children: <Widget>[
              ItemLoadInfoWidget(
                title: '1764',
                subtitle: 'lbs',
              ),
              ItemLoadInfoWidget(
                title: '40*40*40',
                subtitle: 'ln',
              ),
              ItemLoadInfoWidget(
                title: '2',
                subtitle: 'psc',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LoadStatusDropDown extends StatefulWidget {
  const LoadStatusDropDown({
    required this.vm, required this.loadsId, super.key,
  });

  final LoadsDetailsViewModel vm;
  final int? loadsId;

  @override
  State<LoadStatusDropDown> createState() => _LoadStatusDropDownState();
}

class _LoadStatusDropDownState extends State<LoadStatusDropDown> {
  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: AppBordersRadius.borderRadiusAllXS,
          color: whiteColor,
          border: Border.all(color: backgroundBorder),),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<LoadStatus>(
          value: widget.vm.currentStatus,
          dropdownColor: whiteColor,
          iconEnabledColor: Colors.blue,
          isExpanded: true,
          icon: const Icon(CupertinoIcons.chevron_down),
          items: widget.vm.loadsStatusList
              .map<DropdownMenuItem<LoadStatus>>((final LoadStatus status) {
            return DropdownMenuItem<LoadStatus>(
              value: status,
              child: Text(status.description.toUpperCase()),
            );
          }).toList(),
          onChanged: (final LoadStatus? value) {
            widget.vm.currentStatus = value!;
            widget.vm.changeLoadStatus(widget.loadsId ?? 0, widget.vm.currentStatus.id);
          },
        ),
      ),
    );
  }
}

class TypeTransportation extends StatelessWidget {
  const TypeTransportation({
    required this.type, required this.status, required this.icon, super.key,
  });
  final String type;
  final String status;
  final String icon;

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(icon),
        Text(type, style: Theme.of(context).textTheme.titleMedium),
        Text(status, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
