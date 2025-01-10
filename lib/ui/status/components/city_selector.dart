import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/core/services/geocoding_service.dart';
import 'package:lanaexpress/data/managers/logger/log_manager.dart';
import 'package:lanaexpress/generated/router.dart';

final class CitySelectorTextField extends StatelessWidget {
  const CitySelectorTextField({
    required this.controller,
    required this.mapController,
    required this.icon,
    super.key,
    this.itemClick, this.getPlaceDetailWithLatLng,
  });
  final TextEditingController controller;
  final TextEditingController mapController;
  final Function(Prediction)? itemClick;
  final Function(Prediction)? getPlaceDetailWithLatLng;
  final String icon;

  @override
  Widget build(final BuildContext context) {
    return GooglePlaceAutoCompleteTextField(
      googleAPIKey: GoogleMapsApiKey.googleMapsKey,
      textEditingController: controller,
      placeType: PlaceType.geocode,
      getPlaceDetailWithLatLng: getPlaceDetailWithLatLng,
      inputDecoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppSizes.sizeM,
          horizontal: AppSizes.sizeS,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: AppSizes.size6),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: indicatorColor),
              ),
            ),
            child: InkWell(
              child: Image.asset(icon),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (final BuildContext context) => MapScreen(
                      controller: mapController,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        hintText: LoadsStatus.chooseLocation,
      ),
      debounceTime: 500,
      itemClick: itemClick,
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({required this.controller, super.key});
  final TextEditingController controller;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  double _selectedLatitude = 0.0;
  double _selectedLongitude = 0.0;
  LatLng? _selectedLocation;
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _checkLocationPermissions();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkLocationPermissions();
  }

  Future<void> _checkLocationPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      _showLocationServiceError();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, show an explanatory UI
        _showPermissionDeniedDialog();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, show an explanatory UI
      _showPermissionDeniedForeverDialog();
      return;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });

      if (mapController != null && _currentLocation != null) {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _currentLocation!,
              zoom: 15,
            ),
          ),
        );
      }
    } catch (e) {
      LogManager().log(e);
    }
  }

  void _onMapPlaceSelected(
    final double latitude,
    final double longitude,
  ) async {
    _selectedLatitude = latitude;
    _selectedLongitude = longitude;

    // Отримання назви місця за координатами
    final String? address = await GeocodingService.getAddressFromCoordinates(
      _selectedLatitude,
      _selectedLongitude,
    );
    if (address != null) {
      // Встановлення назви місця в контролер
      widget.controller.text = address;
    }
  }

  void _showLocationServiceError() {
    showDialog(
      context: context,
      builder: (final BuildContext context) {
        return AlertDialog(
          title: const Text('Location Services Disabled'),
          content: const Text(
            'Please enable location services to use this feature.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (final BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Denied'),
          content: const Text(
            'This app needs location permissions to show your current location on the map.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showPermissionDeniedForeverDialog() {
    showDialog(
      context: context,
      builder: (final BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Permanently Denied'),
          content: const Text(
            'Location permissions are permanently denied, we cannot request permissions. '
            'Please go to settings and enable location permissions for this app.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () async {
                await openAppSettings();
                if(context.mounted) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _currentLocation ?? const LatLng(0, 0),
                zoom: 15,
              ),
              onMapCreated: (final GoogleMapController controller) {
                setState(() {
                  mapController = controller;
                });
                if (_currentLocation != null) {
                  mapController!.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: _currentLocation!,
                        zoom: 15,
                      ),
                    ),
                  );
                }
              },
              onTap: (final LatLng latLng) async {
                setState(() {
                  _selectedLocation = latLng;
                });
                _onMapPlaceSelected(latLng.latitude, latLng.longitude);
                AppRouter().maybePop(context);
              },
              markers: _selectedLocation != null
                  ? <Marker>{
                      Marker(
                        markerId: const MarkerId('selectedLocation'),
                        position: _selectedLocation!,
                      ),
                    }
                  : <Marker>{},
            ),
    );
  }
}
