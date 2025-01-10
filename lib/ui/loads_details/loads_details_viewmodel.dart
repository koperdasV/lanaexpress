import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/core/base/ui/base_controller.dart';
import 'package:lanaexpress/core/services/loads_service.dart';
import 'package:lanaexpress/data/managers/logger/log_manager.dart';
import 'package:lanaexpress/domain/models/lana_files.dart';
import 'package:lanaexpress/domain/models/loads_model.dart';
import 'package:lanaexpress/domain/models/loads_statuses.dart';
import 'package:lanaexpress/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

final class LoadsDetailsViewModel extends BaseController {
  late final LoadsService _loadsService = LoadsService.to;

  LoadsResponse _currentLoads = LoadsResponse();
  LoadsResponse get currentLoads => _currentLoads;

  List<LoadStatus> _loadsStatusList = <LoadStatus>[];
  List<LoadStatus> get loadsStatusList => _loadsStatusList;

  List<LanaFiles> _lanaFilesList = <LanaFiles>[];
  List<LanaFiles> get lanaFilesList => _lanaFilesList;

  List<LanaFiles> _pickUpList = <LanaFiles>[];
  List<LanaFiles> get pickUpList => _pickUpList;

  List<LanaFiles> _rateFilesList = <LanaFiles>[];
  List<LanaFiles> get rateFilesList => _rateFilesList;

  List<LanaFiles> _deliveryFilesList = <LanaFiles>[];
  List<LanaFiles> get deliveryFilesList => _deliveryFilesList;
  set deliveryFilesList(final List<LanaFiles> deliveryFilesList) {
    _deliveryFilesList = deliveryFilesList;
    notifyListeners();
  }

  LoadStatus _currentStatus = LoadStatus(id: 0, description: '');
  LoadStatus get currentStatus => _currentStatus;
  set currentStatus(final LoadStatus currentStatus) {
    _currentStatus = currentStatus;
    notifyListeners();
  }

  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
  Map<PolylineId, Polyline> get polylines => _polylines;
  set setPolylines(final Map<PolylineId, Polyline> polylines) {
    _polylines = polylines;
    notifyListeners();
  }

  List<File> imageFiles = <File>[];

  late final CameraPosition initialLocation =
      const CameraPosition(target: LatLng(0.0, 0.0));
  late GoogleMapController mapController;
  late Position currentPosition;
  //String _currentAddress = '';

  late final TextEditingController startAddressController =
      TextEditingController();
  late final TextEditingController destinationAddressController =
      TextEditingController();

  late final FocusNode startAddressFocusNode = FocusNode();
  late final FocusNode desrinationAddressFocusNode = FocusNode();

  Set<Marker> markers = <Marker>{};

  double? startLatitude;
  double? startLongitude;
  double? destinationLatitude;
  double? destinationLongitude;

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  Future<void> openImagePicker(
    final bool isCamera,
    final String fileType,
    final int loadsId,
    final List<LanaFiles> listPhoto,
  ) async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage;
    if (isCamera) {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedImage = await picker.pickImage(source: ImageSource.gallery);
    }
    final LanaFiles lanaPhoto = LanaFiles();

    if (pickedImage != null) {
      setBusy(true);
      // Файл вибрано успішно, можна обробити його
      final File imageFile = File(pickedImage.path);
      lanaPhoto.url = imageFile.path;
      listPhoto.add(lanaPhoto);

      await _loadsService.uploadFiles(loadsId, imageFile.path, fileType);
      await getAllDocuments();
      setBusy(false);
      toastCheck('File was uploaded');
    } else {
      // Користувач скасував вибір фото
    }
    setBusy(false);
  }

  Future<void> deleteImages(
    final int loadId,
    final int fileId,
    final String fileType,
    final List<LanaFiles> listPhoto,
  ) async {
    setBusy(true);
    try {
      await _loadsService.deleteFiles(loadId, fileId, fileType);

      // Видаляємо файл зі списку lanaFilesList
      listPhoto.removeWhere((final LanaFiles file) => file.id == fileId);

      notifyListeners();
      await toastCheck('File was deleted');
      setBusy(false);
    } catch (e) {
      LogManager().log(e);
      setBusy(false);
    }
  }

  void changeStatus() {
    _currentStatus.id = _currentLoads.status ?? 0;
    for (final LoadStatus status in _loadsStatusList) {
      if (status.id == _currentLoads.status) {
        _currentStatus = status;
        break;
      }
    }
  }

  Future<void> init() async {
    await getLoadsStatuses();
    startLatitude = double.tryParse(currentLoads.pkpLat ?? '') ?? 0.0;
    startLongitude = double.tryParse(currentLoads.pkpLng ?? '') ?? 0.0;
    destinationLatitude = double.tryParse(currentLoads.delLat ?? '') ?? 0.0;
    destinationLongitude = double.tryParse(currentLoads.delLng ?? '') ?? 0.0;
    addCustomIcon();
    changeStatus();
  }

  Future<void> changeLoadStatus(final int loadId, final int statusId) async {
    try {
      _loadsService.changeLoadStatus(loadId, statusId);
      toastCheck('Status was updated', gravity: ToastGravity.TOP);
    } catch (e, stackTrace) {
      handleError(error, stackTrace);
    }
  }

  Future<void> getLoadById(final int id) async {
    setBusy(true);
    try {
      final LoadsResponse? res = await _loadsService.getLoadsById(id);
      if (res != null) {
        _currentLoads = res;
        notifyListeners();
        setBusy(false);
      }
    } catch (e, stackTrace) {
      handleError(error, stackTrace);
      setBusy(false);
    }
  }

  Future<void> getLoadsStatuses() async {
    try {
      final List<LoadStatus>? res = await _loadsService.getLoadsStatuses();
      if (res != null) {
        _loadsStatusList = res;
        notifyListeners();
      }
    } catch (e, stackTrace) {
      handleError(error, stackTrace);
    }
  }

  Future<void> getRateFiles(final int loadsId, final String typeFile) async {
    try {
      final List<LanaFiles>? res =
          await _loadsService.getFiles(loadsId, typeFile);
      if (res != null) {
        _rateFilesList = res;
      }
    } catch (e, stackTrace) {
      handleError(error, stackTrace);
    }
  }

  Future<void> getLanaFiles(final int loadsId, final String typeFile) async {
    try {
      final List<LanaFiles>? res =
          await _loadsService.getFiles(loadsId, typeFile);
      if (res != null) {
        _lanaFilesList = res;
        notifyListeners();
      }
    } catch (e, stackTrace) {
      handleError(error, stackTrace);
    }
  }

  Future<void> getDeliveryFiles(
    final int loadsId,
    final String typeFile,
  ) async {
    setBusy(true);
    try {
      final List<LanaFiles>? res =
          await _loadsService.getFiles(loadsId, typeFile);
      if (res != null) {
        _deliveryFilesList = res;
        setBusy(false);
      }
    } catch (e, stackTrace) {
      handleError(error, stackTrace);
    }
  }

  Future<void> getPickUpFiles(final int loadsId, final String typeFile) async {
    try {
      final List<LanaFiles>? res =
          await _loadsService.getFiles(loadsId, typeFile);
      if (res != null) {
        _pickUpList = res;
      }
    } catch (e, stackTrace) {
      handleError(error, stackTrace);
    }
  }

  Future<bool> calculateDistance() async {
    try {
      final String startCoordinatesString = '($startLatitude, $startLongitude)';
      final String destinationCoordinatesString =
          '($destinationLatitude, $destinationLongitude)';

      // Start Location Marker
      final Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude ?? 0.0, startLongitude ?? 0.0),
        infoWindow: InfoWindow(
          title: currentLoads.pkpCity,
          snippet: currentLoads.pkpAddress,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );

      // Destination Location Marker
      final Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position:
            LatLng(destinationLatitude ?? 0.0, destinationLongitude ?? 0.0),
        infoWindow: InfoWindow(
          title: currentLoads.delCity,
          snippet: currentLoads.delAddress,
        ),
        icon: markerIcon,
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

      late PolylinePoints polylinePoints;

      final List<LatLng> polylineCoordinates = <LatLng>[];

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
                PointLatLng(destinationLatitude, destinationLongitude));
        // request: PolylineRequest(
        //     origin: PointLatLng(startLatitude, startLongitude),
        //     destination: PointLatLng(destinationLatitude, destinationLongitude),
        //     mode: TravelMode.driving,
        //   ),

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
        _polylines[id] = polyline;
      }

      await createPolylines(
        startLatitude ?? 0.0,
        startLongitude ?? 0.0,
        destinationLatitude ?? 0.0,
        destinationLongitude ?? 0.0,
      );

      double totalDistance = 0.0;

      // Calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      notifyListeners();

      return true;
    } catch (e) {
      LogManager().log(e.toString());
    }
    return false;
  }

  double _coordinateDistance(
    final dynamic lat1,
    final dynamic lon1,
    final dynamic lat2,
    final dynamic lon2,
  ) {
    const double p = 0.017453292519943295;
    double Function(num radians) c = cos;
    final double a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AssetsIcons.finishIcon,
    ).then((final BitmapDescriptor icon) {
      markerIcon = icon;
      notifyListeners();
    });
  }

  Future<void> getAllDocuments() async {
    await getPickUpFiles(_currentLoads.id ?? 0, 'pick-up-images-files');
    await getRateFiles(_currentLoads.id ?? 0, 'rate-confirmation-files');
    await getDeliveryFiles(_currentLoads.id ?? 0, 'delivery-images-files');
    await getLanaFiles(_currentLoads.id ?? 0, 'proof-of-delivery-files');
  }

  Future<void> openGoogleMaps(
    final double? originLat,
    final double? originLng,
    final double? destLat,
    final double? destLng,
  ) async {
    final String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&origin=$originLat,$originLng&destination=$destLat,$destLng&travelmode=driving';

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }
}
