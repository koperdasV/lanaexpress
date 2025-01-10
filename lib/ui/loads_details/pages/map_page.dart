import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/ui/loads_details/loads_details_viewmodel.dart';
import 'package:lanaexpress/ui/loads_details/pages/details_page.dart';
import 'package:lanaexpress/utils/base_button.dart';

@RoutePage()
final class MapPage extends StatefulWidget {
  const MapPage({required this.viewModel, super.key});
  final LoadsDetailsViewModel viewModel;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(final BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.fromLTRB(AppSizes.sizeM, 0, AppSizes.sizeM, 0),
          child: SizedBox(
            height: 500,
            child: GoogleMap(
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: widget.viewModel.initialLocation,
              onMapCreated: (final GoogleMapController controller) {
                widget.viewModel.mapController = controller;
                widget.viewModel.calculateDistance();
              },
              markers: Set<Marker>.from(widget.viewModel.markers),
              polylines: Set<Polyline>.of(widget.viewModel.polylines.values),
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
                  vm: widget.viewModel,
                  loadsId: widget.viewModel.currentLoads.id,
                ),
                const SizedBox(height: AppSizes.sizeXL),
                BaseButton(
                  title: 'Open in Google Maps',
                  onPressed: () {
                    final double? originLatitude =
                        widget.viewModel.startLatitude;
                    final double? originLongitude =
                        widget.viewModel.startLongitude;
                    final double? destinationLatitude =
                        widget.viewModel.destinationLatitude;
                    final double? destinationLongitude =
                        widget.viewModel.destinationLongitude;
                    if (originLatitude != null &&
                        originLongitude != null &&
                        destinationLatitude != null &&
                        destinationLongitude != null) {
                      widget.viewModel.openGoogleMaps(
                        originLatitude,
                        originLongitude,
                        destinationLatitude,
                        destinationLongitude,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('The destination is not specified'),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: AppSizes.size6),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
