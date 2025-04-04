import ComposableArchitecture
import SwiftUI
import Common

// MARK: - AppView

@MainActor
public struct AppView: View {
  public init() {
    logs.info("Logging Test - App View")
  }

  public var body: some View {
    MainTabView(
      store: Store<MainTabFeature.State, MainTabFeature.Action>(
        initialState: .init(),
        reducer: { MainTabFeature() }
      )
    )
  }
}
