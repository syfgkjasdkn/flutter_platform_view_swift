import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var flutterResult: FlutterResult?

  override func application(_ application: UIApplication,
                            didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let flutterViewController = window.rootViewController as! FlutterViewController

    let flutterChannel = FlutterMethodChannel(name: "samples.flutter.io/platform_view",
                                              binaryMessenger: flutterViewController)

    flutterChannel.setMethodCallHandler { [unowned self] (call, result) in
      if call.method == "switchView" {
        self.flutterResult = result

        let platformViewController = flutterViewController
          .storyboard?
          .instantiateViewController(withIdentifier: "PlatformView") as! PlatformViewController

        platformViewController.counter = call.arguments as! Int
        platformViewController.delegate = self

        let navigationController = UINavigationController(rootViewController: platformViewController)
        navigationController.navigationBar.topItem?.title = "Platform View"
        flutterViewController.present(navigationController, animated: false)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

extension AppDelegate: PlatformViewControllerDelegate {
  func didUpdateCounter(counter: Int) {
    flutterResult?(counter)
  }
}
