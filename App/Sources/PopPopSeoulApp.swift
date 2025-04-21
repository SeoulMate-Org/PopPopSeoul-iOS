import SwiftUI
import ComposableArchitecture
import FacebookCore
import Features
//import GoogleSignIn
//import FirebaseCore

// MARK: - AppDelegate

class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    //    FirebaseApp.configure() // ✅ Firebase 초기화
    
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
    
    //    var handled: Bool
    //    handled = GIDSignIn.sharedInstance.handle(url)
    //    if handled {
    //      // Handle other custom URL types.
    //      return true
    //    }
    
    return ApplicationDelegate.shared.application(app, open: url,
                                                  sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                  annotation: options[UIApplication.OpenURLOptionsKey.annotation])
  }
}

// MARK: - SceneDelegate

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    guard let url = URLContexts.first?.url else {
      return
    }
    
    ApplicationDelegate.shared.application(UIApplication.shared, open: url,
                                           sourceApplication: nil, annotation: [UIApplication.OpenURLOptionsKey.annotation])
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
        //          .onOpenURL { url in
        //            GIDSignIn.sharedInstance.handle(url)
        //          }
        //          .onAppear {
        //            GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
        //              // Check if `user` exists; otherwise, do something with `error`
        //            }
        //          }
      }
      //      } else if _XCTIsTesting {
      //        EmptyView()
    }
  }
}
