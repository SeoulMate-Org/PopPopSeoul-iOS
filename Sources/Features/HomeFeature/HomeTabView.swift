//
//  HomeTabView.swift
//  PopPopSeoulKit
//
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import Common
import SharedTypes

struct HomeTabView: View {
  let store: StoreOf<HomeTabFeature>
  
  init(store: StoreOf<HomeTabFeature>) {
    self.store = store
  }
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(spacing: 0) {
        HeaderView(type: .titleOnly(title: "Logo"))
        
        ScrollView {
          VStack(spacing: 0) {
            HomeChallengeBannerSection(challenges: []) { _ in }
            HomeAccessPromptSection(type: .login)
              .padding(.top, 48)
            
            HomeThemeChallengeSection(
              selectedTab: viewStore.binding(
                get: \.selectedThemeTab,
                send: HomeTabFeature.Action.selectedThemeTabChanged
              ),
              challengesByTheme: viewStore.themeChallenges,
              themeTabChanged: { tab in
                store.send(.selectedThemeTabChanged(tab))
              }
            )
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
