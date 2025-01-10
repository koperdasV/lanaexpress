import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/ui/loadboard/loadboard_details.dart/permission_provider.dart';
import 'package:lanaexpress/ui/loads_details/loads_details_viewmodel.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mtk;
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.viewModel});

  final LoadsDetailsViewModel viewModel;

  @override
  State<MapPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MapPage> with WidgetsBindingObserver {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  StreamSubscription<Position>? _positionStream;
  List<Marker> markerList = <Marker>[];

  final Marker _destinationMarker = const Marker(
      markerId: MarkerId("destination"),
      position: LatLng(49.36609439587927, 23.51620682600048),);

  Position? _currentPosition;
  List<Polyline> myRouteList = <Polyline>[];
  MapsRoutes route = MapsRoutes();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  Marker? myLocationMarker;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      markerList.add(_destinationMarker);
      setCustomIconForUserLocation();
      checkPermissionAndListenLocation();
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_positionStream != null) {
      _positionStream!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.grey[850],
        onPressed: () {
          getNewRouteFromAPI();
        },
        label: Text(
          "Get Route",
          style: TextStyle(color: Colors.grey[300]),
        ),
      ),
      body: !PermissionProvider.isServiceOn ||
              PermissionProvider.locationPermission !=
                  PermissionStatus.granted
          ? Container(
              color: Colors.grey[700],
              child: const Center(child: CircularProgressIndicator()),)
          : SizedBox(
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
                  if (!_controller.isCompleted) {
                    _controller.complete(controller);
                  }
                  widget.viewModel.mapController = controller;
                  widget.viewModel.calculateDistance();
                },
              markers: Set<Marker>.from(markerList),
              polylines:
                  Set<Polyline>.of(myRouteList),
            ),
            //  GoogleMap(
            //     //style: _darkMapStyle,
            //     polylines: Set<Polyline>.from(myRouteList),
            //     initialCameraPosition: _cameraPos,
            //     markers: Set<Marker>.from(markerList),
            //     onMapCreated: (final GoogleMapController controller) {
            //       if (!_controller.isCompleted) {
            //       _controller.complete(controller);}
            //     },
            //   ),
          ),
    );
  }

  void setCustomIconForUserLocation() {
    Future<Uint8List> getBytesFromAsset(final String path, final int width) async {
      final ByteData data = await rootBundle.load(path);
      final Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
          targetWidth: width,);
      final FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ImageByteFormat.png))!
          .buffer
          .asUint8List();
    }

    // getBytesFromAsset('assets/user_location.png', 64).then((final Uint8List onValue) {
    //   markerIcon = BitmapDescriptor.fromBytes(onValue);
    // });
  }

  void navigationProcess() {
    final List<mtk.LatLng> myLatLngList = <mtk.LatLng>[];
    for (final LatLng data in route.routes.first.points) {
      myLatLngList.add(mtk.LatLng(data.latitude, data.longitude));
    }
    final mtk.LatLng myPosition =
        mtk.LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
    // we check if our location is on route or not
    final int x = mtk.PolygonUtil.locationIndexOnPath(myPosition, myLatLngList, true,
        tolerance: 12,);
    /* x: -1 if point does not lie on or near the polyline. 0 if point is between
            poly[0] and poly[1] (inclusive), 1 if between poly[1] and poly[2]... */
    if (x == -1) {
      getNewRouteFromAPI();
    } else {
      myLatLngList[x] = myPosition;
      myLatLngList.removeRange(0, x);
      myRouteList.first.points.clear();
      myRouteList.first.points
          .addAll(myLatLngList.map((final mtk.LatLng e) => LatLng(e.latitude, e.longitude)));
    }
    if (mounted) {
      setState(() {});
    }
  }

  void getNewRouteFromAPI() async {
    if (route.routes.isNotEmpty) {
      route.routes.clear();
    }
    if (myRouteList.isNotEmpty) {
      myRouteList.clear();
    }
    log("GETTING NEW ROUTE !!");
    await route.drawRoute(<LatLng>[
      LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      LatLng(_destinationMarker.position.latitude,
          _destinationMarker.position.longitude,),
    ], 'route', const Color.fromARGB(255, 33, 155, 255), GoogleMapsApiKey.googleMapsKey,
        );
    myRouteList.add(route.routes.first);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (PermissionProvider.permissionDialogRoute != null &&
          PermissionProvider.permissionDialogRoute!.isActive) {
        Navigator.of(GoogleMapsApiKey.globalNavigatorKey.currentContext!)
            .removeRoute(PermissionProvider.permissionDialogRoute!);
      }
      Future.delayed(const Duration(milliseconds: 250), () async {
        checkPermissionAndListenLocation();
      });
    }
  }

  // Future<void> _loadMapStyles() async {
  //   _darkMapStyle = await rootBundle.loadString(Constants.darkMapStyleJson);
  // }

  void checkPermissionAndListenLocation() {
    PermissionProvider.handleLocationPermission().then((final _) {
      if (_positionStream == null &&
          PermissionProvider.isServiceOn &&
          PermissionProvider.locationPermission == PermissionStatus.granted) {
        startListeningLocation();
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  void startListeningLocation() {
    _positionStream = Geolocator.getPositionStream(
            locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),)
        .listen((final Position? position) {
      if (position != null) {
        log('${position.latitude.toString()}, ${position.longitude.toString()}');
        showMyLocationOnMap(position);
        if (myRouteList.isNotEmpty) {
          navigationProcess();
        }
      }
    });
  }

  void showMyLocationOnMap(final Position position) {
    _currentPosition = position;
    markerList.removeWhere((final Marker e) => e.markerId == const MarkerId("myLocation"));
    myLocationMarker = Marker(
        markerId: const MarkerId("myLocation"),
        position:
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        icon: markerIcon,
        rotation: _currentPosition!.heading,);
    if (markerIcon != BitmapDescriptor.defaultMarker) {
      markerList.add(myLocationMarker!);
    }
    if (mounted) {
      setState(() {});
    }
  }
}