import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/data/managers/logger/log_manager.dart';
import 'package:lanaexpress/domain/models/loadboard_model.dart';

import 'dart:math' show cos, sqrt, asin;

final class MapsWidget extends StatefulWidget {
  const MapsWidget({
    required this.loadboards,
    super.key,
  });
  final Loadboard? loadboards;

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  final CameraPosition _initialLocation =
      const CameraPosition(target: LatLng(0.0, 0.0));
  late GoogleMapController mapController;

  late final TextEditingController startAddressController = TextEditingController();
  late final TextEditingController destinationAddressController =
      TextEditingController();

  late final FocusNode startAddressFocusNode = FocusNode();
  late final FocusNode desrinationAddressFocusNode = FocusNode();

  final String _startAddress = '';
  final String _destinationAddress = '';
  Set<Marker> markers = <Marker>{};

  double? startLatitude;
  double? startLongitude;
  double? destinationLatitude;
  double? destinationLongitude;

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
  List<LatLng> polylineCoordinates = <LatLng>[];
  @override
  void initState() {
    super.initState();
    startLatitude = double.tryParse(widget.loadboards?.lat ?? '') ?? 0.0;
    startLongitude = double.tryParse(widget.loadboards?.lng ?? '') ?? 0.0;
    destinationLatitude =
        double.tryParse(widget.loadboards?.delLat ?? '') ?? 0.0;
    destinationLongitude =
        double.tryParse(widget.loadboards?.delLng ?? '') ?? 0.0;
  }

  // Method for calculating the distance between two places
  Future<bool> _calculateDistance() async {
    try {
      final String startCoordinatesString = '($startLatitude, $startLongitude)';
      final String destinationCoordinatesString =
          '($destinationLatitude, $destinationLongitude)';

      // Start Location Marker
      final Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude ?? 40.6536, startLongitude ?? -73.5866),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: _startAddress,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );

      // Destination Location Marker
      final Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(
          destinationLatitude ?? 37.3169,
          destinationLongitude ?? -89.5459,
        ),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: _destinationAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Adding the markers to the list
      markers.add(startMarker);
      markers.add(destinationMarker);

      // Calculating to check that the position relative
      // to the frame, and pan & zoom the camera accordingly.
      final double? miny = (startLatitude! <= destinationLatitude!)
          ? startLatitude
          : destinationLatitude;
      final double? minx = (startLongitude! <= destinationLongitude!)
          ? startLongitude
          : destinationLongitude;

      final double? maxy = (startLatitude! <= destinationLatitude!)
          ? destinationLatitude
          : startLatitude;
      final double? maxx = (startLongitude! <= destinationLongitude!)
          ? destinationLongitude
          : startLongitude;
      final double? southWestLatitude = miny;
      final double? southWestLongitude = minx;

      final double? northEastLatitude = maxy;
      final double? northEastLongitude = maxx;

      // Accommodate the two locations within the
      // camera view of the map
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast:
                LatLng(northEastLatitude ?? 0.0, northEastLongitude ?? 0.0),
            southwest:
                LatLng(southWestLatitude ?? 0.0, southWestLongitude ?? 0.0),
          ),
          100.0,
        ),
      );
      Future<void> createPolylines(
        final double startLatitude,
        final double startLongitude,
        final double destinationLatitude,
        final double destinationLongitude,
      ) async {
        // Initializing PolylinePoints
        polylinePoints = PolylinePoints();

        // Generating the list of coordinates to be used for
        // drawing the polylines
        final PolylineResult result =
            await polylinePoints.getRouteBetweenCoordinates(
            GoogleMapsApiKey.googleMapsKey,
            PointLatLng(startLatitude, startLongitude),
            PointLatLng(destinationLatitude, destinationLongitude),
        );

        // Adding the coordinates to the list
        if (result.points.isNotEmpty) {
          for (final PointLatLng point in result.points) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          }
        }

        // Defining an ID
        const PolylineId id = PolylineId('poly');

        // Initializing Polyline
        final Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.red,
          points: polylineCoordinates,
          width: 3,
        );

        // Adding the polyline to the map
        polylines[id] = polyline;
      }

      await createPolylines(
        startLatitude ?? 0.0,
        startLongitude ?? 0.0,
        destinationLatitude ?? 0.0,
        destinationLongitude ?? 0.0,
      );

      

      // Calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      setState(() {});

      return true;
    } catch (e) {
      LogManager().log(e.toString());
    }
    return false;
  }

  // Formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277
  double _coordinateDistance(final dynamic lat1, final dynamic lon1, final dynamic lat2, final dynamic lon2) {
    const double p = 0.017453292519943295;
    double Function(num radians) c = cos;
    final double a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

// For controlling the view of the Map
  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: 400,
      height: 290,
      child: Stack(
        children: <Widget>[
          GoogleMap(
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
            markers: Set<Marker>.from(markers),
            polylines: Set<Polyline>.of(polylines.values),
            initialCameraPosition: _initialLocation,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: (final GoogleMapController controller) {
              mapController = controller;
              _calculateDistance();
            },
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipOval(
                    child: Material(
                      color: Colors.blue.shade100, // button color
                      child: InkWell(
                        splashColor: Colors.blue, // inkwell color
                        child: const SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(Icons.add),
                        ),
                        onTap: () {
                          mapController.animateCamera(
                            CameraUpdate.zoomIn(),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipOval(
                    child: Material(
                      color: Colors.blue.shade100, // button color
                      child: InkWell(
                        splashColor: Colors.blue, // inkwell color
                        child: const SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(Icons.remove),
                        ),
                        onTap: () {
                          mapController.animateCamera(
                            CameraUpdate.zoomOut(),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}