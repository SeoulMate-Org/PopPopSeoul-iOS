//
//  HomeTabView.swift
//  PopPopSeoulKit
//
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import Common

struct HomeTabView: View {
  @State var store: StoreOf<HomeTabFeature>
  
  init(store: StoreOf<HomeTabFeature>) {
    self.store = store
  }
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(spacing: 16) {
        Text("위치 권한: \(viewStore.authorizationStatus.rawValue)")
        if let location = viewStore.userLocation {
          Text("현재 위치: \(location.latitude), \(location.longitude)")
        }
      }
      .onAppear {
        viewStore.send(.onAppear)
      }
    }
  }
}

// MARK: Preview

#Preview {
  HomeTabView(
    store: Store<HomeTabFeature.State, HomeTabFeature.Action>(
      initialState: .init(),
      reducer: { HomeTabFeature() }
    )
  )
}

// MARK: - Helper
