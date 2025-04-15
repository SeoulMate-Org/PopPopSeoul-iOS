import SwiftUI
import PopPopSeoulKit
import ComposableArchitecture

// MARK: - AppDelegate

class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    true
  }
}

// MARK: - SeoulMateApp

@main
struct PopPopSeoulApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self)
  var appDelegate

  static let store = Store(initialState: AppFeature.State()) {
    AppFeature()
  }

  var body: some Scene {
    WindowGroup {
      if ProcessInfo.processInfo.environment["UITesting"] == "true" {
        EmptyView()
      } else {
        AppView(store: Self.store)
      }
//      } else if _XCTIsTesting {
//        EmptyView()
    }
  }
}
