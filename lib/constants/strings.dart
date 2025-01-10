import 'package:flutter/material.dart';

abstract class GoogleMapsApiKey {
  static const String googleMapsKey = 'AIzaSyAc2v7UBKrjA4Xz6OuualrEjpUmzHkLj0g';
  static final GlobalKey<NavigatorState> globalNavigatorKey =
      GlobalKey<NavigatorState>();
  static const String androidLocationIntentAddress =
      'android.settings.LOCATION_SOURCE_SETTINGS';
}

const String login = 'Log In';
const String email = 'Email or phone*';
const String password = 'Password*';
const String getStarted = 'Get Started';
const String allow = 'Allow';
const String skip = 'Skip';
const String received = 'Received:';

//navbar
abstract class NavBarTitles {
  static const String status = 'Status';
  static const String loadboard = 'Loadboard';
  static const String bids = 'Bids';
  static const String loads = 'Loads';
  static const String profile = 'Profile';
}

//alert dialog
const String date = 'Date';
const String time = 'Time';
const String apply = 'Apply';
const String filter = 'Filter';
const String youPlace = 'You place a BID';

//status page
abstract class LoadsStatus {
  static const String setAvailableDate = 'Set available date';
  static const String chooseLocation = 'Choose your location';
  static const String setActive = 'Set Active';
  static const String inActive = 'InActive';
  static const String driver = 'Select Driver';
  static const String truckType = 'Truck type';
  static const String currentStatusText = 'Your current status:';
  static const String loadStatus = 'Load Status';
  static const String driverAnotherDate =
      'Driver will be available at another date';
}

//notification
const String notification = 'Notification';
const String accept = 'Accept';
const String save = 'Save';
const String cancel = 'Cancel';

//upload photo
const String uploadPhotoOrDocuments = 'Upload photo or documents';

abstract class ProfileTiles {
  static const String uploadPhoto = 'Upload photo';
  static const String taskName = 'Task Name';
  static const String clickHere = 'Click here to upload vehicle registration.';
}

abstract class PlaceDialogTitles {
  static const String origin = 'Origin: ';
  static const String destanation = 'Destanation: ';
  static const String price = 'Price: ';
  static const String driver = 'Driver: ';
  static const String truckType = 'Truck type: ';
}

abstract class ImagePikerType {
  static const String gallery = 'Gallery';
  static const String camera = 'Camera';
}

abstract class FileType {
  static const String pdf = 'pdf';
  static const String jpg = 'jpg';
}
