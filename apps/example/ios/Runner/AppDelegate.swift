import CoreLocation
import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let headingStreamHandler = DiabRutaHeadingStreamHandler()

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    if let controller = window?.rootViewController as? FlutterViewController {
      let channel = FlutterEventChannel(
        name: "diabruta/ios_heading",
        binaryMessenger: controller.binaryMessenger
      )
      channel.setStreamHandler(headingStreamHandler)
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

/// Streams iOS system-calibrated compass heading via CoreLocation
/// (`CLHeading.trueHeading` / `magneticHeading`).
///
/// `sensors_plus` on iOS reads raw uncalibrated `CMMagnetometerData`, which
/// includes strong hard-iron bias from internal speakers/MagSafe magnets.
/// CoreLocation applies Apple's full gyro + magnetometer calibration.
private final class DiabRutaHeadingStreamHandler: NSObject, FlutterStreamHandler, CLLocationManagerDelegate {
  private var locationManager: CLLocationManager?
  private var eventSink: FlutterEventSink?

  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    guard CLLocationManager.headingAvailable() else {
      return FlutterError(
        code: "UNAVAILABLE",
        message: "Heading sensor is not available on this device.",
        details: nil
      )
    }

    eventSink = events
    let manager = CLLocationManager()
    manager.delegate = self
    manager.headingFilter = kCLHeadingFilterNone
    manager.headingOrientation = .portrait
    manager.startUpdatingHeading()
    locationManager = manager
    return nil
  }

  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    locationManager?.stopUpdatingHeading()
    locationManager?.delegate = nil
    locationManager = nil
    eventSink = nil
    return nil
  }

  func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
    // Negative headingAccuracy indicates an invalid/uncalibrated reading.
    guard newHeading.headingAccuracy >= 0 else { return }
    let degrees = newHeading.trueHeading >= 0 ? newHeading.trueHeading : newHeading.magneticHeading
    guard degrees >= 0 else { return }
    eventSink?(Double(degrees))
  }

  func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
    return true
  }
}
