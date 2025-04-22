import SwiftUI
import DesignSystem
import ComposableArchitecture
import Common
import FirebaseCore

// MARK: - AppView

@MainActor
public struct AppView: View {
  let store: StoreOf<AppFeature>
  
  public init(store: StoreOf<AppFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Group {
        switch viewStore.route {
        case .launching:
          SplashView(store: store.scope(state: \.splash, action: \.splash))
        case .mainTab:
          // TODO: mainTabFeature 연결 시 교체
          Text("MainTabView Placeholder")
        }
      }
      .onAppear {
        viewStore.send(.onAppear)
      }
    }
  }
}
