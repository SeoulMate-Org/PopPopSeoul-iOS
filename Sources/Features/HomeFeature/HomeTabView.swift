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
      VStack(spacing: 0) {
        HeaderView(type: .titleOnly(title: "Logo"))
        
        ScrollView {
          VStack(spacing: 0) {
            HomeChallengeBannerSection(challenges: mockChallenges) { _ in }
            HomeAccessPromptSection(type: .login)
              .padding(.top, 48)
          }
          .frame(maxWidth: .infinity)
        }
      }
      .frame(maxHeight: .infinity)
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
