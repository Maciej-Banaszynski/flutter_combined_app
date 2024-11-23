import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GMSServices.provideAPIKey("AIzaSyCZ5GCMTIgVDb5Hj6DjAapwssz918zk2Gg")
        GeneratedPluginRegistrant.register(with: self)
        
        let controller = window?.rootViewController as! FlutterViewController
        let metricsChannel = FlutterMethodChannel(name: "com.metricsmanager.channel",
                                                  binaryMessenger: controller.binaryMessenger)
        
        metricsChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "getMetrics" {
                let metrics = MetricsManager.shared.collectMetrics()
                result(metrics)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)

    }
}
