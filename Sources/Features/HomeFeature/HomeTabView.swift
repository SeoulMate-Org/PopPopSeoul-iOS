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
import Clients

struct HomeTabView: View {
  let store: StoreOf<HomeTabFeature>
  @ObservedObject var viewStore: ViewStore<HomeTabFeature.State, HomeTabFeature.Action>
  
  init(store: StoreOf<HomeTabFeature>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
      VStack(spacing: 0) {
        HeaderView(type: .logo)
        
        ScrollView {
          VStack(spacing: 0) {
            if viewStore.bannerList.count > 0 {
              HomeChallengeBannerSection(challenges: viewStore.bannerList) { _ in }
            }
            
            if viewStore.locationListType == .loginRequired {
              HomeAccessPromptSection(type: .login)
                .padding(.top, 48)
            } else if viewStore.locationListType == .locationAuthRequired {
              HomeAccessPromptSection(type: .location)
                .padding(.top, 48)
            }
            
            if viewStore.locationList.count > 0 {
              HomeChallengeLocationSection(
                challenges: viewStore.locationList,
                onTapped: { id in
                  store.send(.tappedChallenge(id: id))
                })
              .padding(.top, 48)
            }
            
            HomeThemeChallengeSection(
              selectedTab: viewStore.binding(
                get: \.selectedTheme,
                send: HomeTabFeature.Action.themeChanged
              ),
              challengesByTheme: viewStore.themeChallenges,
              themeTabChanged: { tab in
                viewStore.send(.themeChanged(tab))
              },
              onLikeTapped: { _ in },
              onMoreTapped: { })
            .padding(.top, 48)
            
          }
          .frame(maxWidth: .infinity)
        }
      }
      .frame(maxHeight: .infinity)
      .onAppear {
        store.send(.onAppear)
      
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
