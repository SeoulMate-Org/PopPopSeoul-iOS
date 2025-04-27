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
  
  init(store: StoreOf<HomeTabFeature>) {
    self.store = store
  }
  
  var body: some View {
      VStack(spacing: 0) {
        HeaderView(type: .logo)
        
        ScrollView {
          VStack(spacing: 0) {
            WithViewStore(store, observe: { $0.bannerList }) { listStore in
              if listStore.state.count > 0 {
                HomeChallengeBannerSection(challenges: listStore.state) { _ in }
              }
            }
            
            WithViewStore(store, observe: { $0.locationListType }) { typeStore in
              if typeStore.state == .loginRequired {
                HomeAccessPromptSection(type: .login)
                  .padding(.top, 48)
              } else if typeStore.state == .locationAuthRequired {
                HomeAccessPromptSection(type: .location)
                  .padding(.top, 48)
              }
              
              WithViewStore(store, observe: { $0.locationList }) { listStore in
                if listStore.count > 0 {
                  HomeChallengeLocationSection(
                    challenges: listStore.state,
                    onTapped: { id in
                      store.send(.tappedChallenge(id: id))
                  })
                  .padding(.top, 48)
                }
              }
            }
            
//            HomeThemeChallengeSection(
//              selectedTab: viewStore.binding(
//                get: \.selectedThemeTab,
//                send: HomeTabFeature.Action.selectedThemeTabChanged
//              ),
//              challengesByTheme: viewStore.themeChallenges,
//              themeTabChanged: { tab in
//                store.send(.selectedThemeTabChanged(tab))
//              }
//            )
//            .padding(.top, 48)
            
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
