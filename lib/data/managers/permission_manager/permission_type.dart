enum PermissionType {
  // Camera
  camera,

  // Read External Storage (Android)
  storage,

  // Write External Storage (Android)
  manageExternalStorage,
// recieve notifications
  notification,
  location,
  // Access Coarse Location (Android) / When In Use iOS
  accessCoarseLocation,

  // Access Fine Location (Android) / When In Use iOS
  accessFineLocation,

  // Access Fine Location (Android) / When In Use iOS
  whenInUseLocation,

  // Access Fine Location (Android) / Always Location iOS
  alwaysLocation,

  photos,

  mediaLibrary,
}