import SwiftUI
import ComposableArchitecture
import FacebookCore
import Features
import GoogleSignIn
import FirebaseCore
import NMapsMap
import Common

// MARK: - AppDelegate

class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    ApplicationDelegate.shared.application(
      application,
      didFinishLaunchingWithOptions: launchOptions
    )
    return true
  }
  func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    
    return ApplicationDelegate.shared.application(app, open: url,
                                                  sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                  annotation: options[UIApplication.OpenURLOptionsKey.annotation])
  }
}

// MARK: - SeoulMateApp

@main
struct PopPopSeoulApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self)
  var appDelegate
  
  init() {
    FirebaseApp.configure()
    NMFAuthManager.shared().ncpKeyId = Constants.naverClientId
  }
  
  var body: some Scene {
    WindowGroup {
      if ProcessInfo.processInfo.environment["UITesting"] == "true" {
        EmptyView()
      } else {
        AppView(store: Store<AppFeature.State, AppFeature.Action>(
          initialState: .init(),
          reducer: { AppFeature() }
        ))
        .onAppear {
          GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            // Check if `user` exists; otherwise, do something with `error`
          }
        }
        .onOpenURL { url in
          GIDSignIn.sharedInstance.handle(url)
        }
      }
    }
  }
}
