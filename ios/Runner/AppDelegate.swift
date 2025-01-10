import UIKit
import Flutter
import GoogleMaps
import CoreLocation
import flutter_local_notifications
import flutter_background_service_ios

@main
@objc class AppDelegate: FlutterAppDelegate {
  let locationManager = CLLocationManager()
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
    GeneratedPluginRegistrant.register(with: registry)
  }
    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "your.custom.task.identifier"
    GeneratedPluginRegistrant.register(with: self)
    locationManager.requestAlwaysAuthorization()
    GMSServices.provideAPIKey( "AIzaSyAc2v7UBKrjA4Xz6OuualrEjpUmzHkLj0g" )
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
