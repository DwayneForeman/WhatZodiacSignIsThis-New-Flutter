 import Flutter
 import UIKit
 import workmanager

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

   // Set the plugin registrant callback for Workmanager
      WorkmanagerPlugin.setPluginRegistrantCallback { registry in
        GeneratedPluginRegistrant.register(with: registry)
      }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
//import Flutter
//import UIKit
//import workmanager

// @main
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     // Register the Workmanager plugin
//     WorkmanagerPlugin.register(with: self.registrar(forPlugin: "WorkmanagerPlugin")!)
//
//     // Set the plugin registrant callback
//     WorkmanagerPlugin.setPluginRegistrantCallback { registry in
//       GeneratedPluginRegistrant.register(with: registry)
//     }
//
//     // Register all plugins
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }
//
