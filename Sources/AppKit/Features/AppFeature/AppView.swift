import SwiftUI
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
    WithViewStore(store, observe: \.route) { viewStore in
      ZStack {
        switch viewStore.state {
        case .launching:
          Assets.Images.splash.swiftUIImage
            .resizable()
            .scaledToFill()
            .frame(maxWidth: CGFloat.infinity, maxHeight: CGFloat.infinity)
            .clipped()
            .ignoresSafeArea()
          
        case .mainTab:
          MainTabView(
            store: Store<MainTabFeature.State, MainTabFeature.Action>(
              initialState: .init(),
              reducer: { MainTabFeature() }
            )
          )
        }
      }
    }
    .alert(
      store: store.scope(state: \.$destination.alert,
                         action: \.destination.alert)
    )
    .onAppear { store.send(.onAppear) }
    
  }
}
