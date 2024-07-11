import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
       let xml = FileManager.default.contents(atPath: path),
       let secrets = try? PropertyListDecoder().decode([String: String].self, from: xml),
       let apiKey = secrets["GoogleMapsAPIKey"] {
      GMSServices.provideAPIKey(apiKey)
    } else {
      fatalError("Google Maps API key not found")
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
