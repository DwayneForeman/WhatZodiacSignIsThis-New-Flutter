import Flutter
import UIKit
import workmanager

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // Register Flutter plugins
    GeneratedPluginRegistrant.register(with: self)

    //WorkmanagerPlugin.registerPeriodicTask(with: self.registrar(forPlugin: "com.AppWithThat.WhatZodiacSignIsThis.workmanager.WorkmanagerPlugin")!)

//Register periodic tasks
    WorkmanagerPlugin.registerPeriodicTask(
        withIdentifier: "com.whatsignisthis.morningNotification",
        frequency: NSNumber(value: 24 * 60 * 60) // 24 hours
    )
    WorkmanagerPlugin.registerPeriodicTask(
        withIdentifier: "com.whatsignisthis.eveningNotification",
        frequency: NSNumber(value: 24 * 60 * 60) // 24 hours
    )

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}