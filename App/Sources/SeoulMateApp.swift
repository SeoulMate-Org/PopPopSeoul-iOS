import SwiftUI
import SeoulMateKit
import XCTestDynamicOverlay

// MARK: - AppDelegate

class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    true
  }
}

// MARK: - WhisperBoardApp

@main
struct SeoulMateApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
    WindowGroup {
      if ProcessInfo.processInfo.environment["UITesting"] == "true" {
        TestingAppView()
      } else if _XCTIsTesting {
        EmptyView()
      } else {
        AppView()
      }
    }
  }
}
