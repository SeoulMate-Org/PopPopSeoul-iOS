import SwiftUI
import DesignSystem
import ComposableArchitecture
import Common

// MARK: - AppView

@MainActor
public struct AppView: View {
  let store: StoreOf<AppFeature>
  
  public init(store: StoreOf<AppFeature>) {
    self.store = store
  }
  
  public var body: some View {
    switch store.state.destination {
    case .splash:
      if let splashStore = store.scope(state: \.destination?.splash, action: \.destination.splash) {
        SplashView(store: splashStore)
      }
      
    case .onboarding:
      if let onboardingStore = store.scope(state: \.destination?.onboarding, action: \.destination.onboarding) {
        OnboardingView(store: onboardingStore)
      }
      
    case .mainTab:
      if let mainTabStore = store.scope(state: \.destination?.mainTab, action: \.destination.mainTab) {
        MainTabView(store: mainTabStore)
      }
      
    case .login:
      if let loginStore = store.scope(state: \.destination?.login, action: \.destination.login) {
        LoginView(store: loginStore)
      }
    case .none:
      EmptyView()
    }
  }
}
