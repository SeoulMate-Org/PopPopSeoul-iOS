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
import SharedAssets
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
      
      ScrollView(showsIndicators: false) {
        VStack(spacing: 0) {
          if viewStore.bannerList.count > 0 {
            HomeBannerSection(
              isCultural: store.bannerState?.currentType == .cultural,
              challenges: viewStore.bannerList,
              onLikeTapped: { challenge in
                viewStore.send(.tappedLike(challenge))
              },
              onTapped: { id in
                viewStore.send(.tappedChallenge(id: id))
              })
          }
          
          if viewStore.locationListType == .loginRequired {
            HomeAccessPromptSection(type: .login)
              .onTapGesture {
                viewStore.send(.showAlert(.login))
              }
              .padding(.top, 48)
          } else if viewStore.locationListType == .locationAuthRequired {
            HomeAccessPromptSection(type: .location)
              .onTapGesture {
                viewStore.send(.showAlert(.onLocation))
              }
              .padding(.top, 48)
          }
          
          if viewStore.locationList.count > 0 {
            HomeLocationSection(
              isDefault: viewStore.locationListType == .defaultList,
              challenges: viewStore.locationList,
              onTapped: { id in
                store.send(.tappedChallenge(id: id))
              })
            .padding(.top, 48)
          }
          
          if viewStore.themeChallenges[.mustSeeSpots]?.count ?? 0 > 0 {
            HomeThemeSection(
              selectedTab: viewStore.binding(
                get: \.selectedTheme,
                send: HomeTabFeature.Action.themeChanged
              ),
              challengesByTheme: viewStore.themeChallenges,
              themeTabChanged: { tab in
                viewStore.send(.themeChanged(tab))
              },
              onLikeTapped: { challenge in
                viewStore.send(.tappedLike(challenge))
              },
              onMoreTapped: {
                viewStore.send(.tappedThemeMore)
              },
              onTapped: { id in
                viewStore.send(.tappedChallenge(id: id))
              })
            .padding(.top, 48)
          }
          
          if viewStore.missingList.count > 0 {
            HomeMissingSection(
              isMissing: true,
              challenges: viewStore.missingList,
              onTapped: { id in
                store.send(.tappedChallenge(id: id))
              },
              onStartTapped: { id in
                store.send(.tappedStart(id))
              })
            .padding(.top, 48)
          }
          
          if viewStore.challengeList.count > 0 {
            HomeMissingSection(
              isMissing: false,
              challenges: viewStore.challengeList,
              onTapped: { id in
                store.send(.tappedChallenge(id: id))
              },
              onStartTapped: { id in
                store.send(.tappedStart(id))
              })
            .padding(.top, 48)
          }
          
          if viewStore.similarList.count > 0 {
            HomeSimilarSection(
              lastAttractionName: viewStore.similarAttraction,
              challenges: viewStore.similarList,
              onTapped: { id in
                store.send(.tappedChallenge(id: id))
              })
            .padding(.top, 48)
          }
          
          if viewStore.rankList.count > 0 {
            HomeRankSection(
              challenges: viewStore.rankList,
              onLikeTapped: { challenge in
                viewStore.send(.tappedLike(challenge))
              }, onTapped: { id in
                viewStore.send(.tappedChallenge(id: id))
              })
            .padding(.top, 48)
          }
        }
        .frame(maxWidth: .infinity)
      }
    }
    .frame(maxHeight: .infinity)
    .background(Colors.appWhite.swiftUIColor)
    .onAppear {
      switch viewStore.onAppearType {
      case .firstTime, .tabReappeared:
        viewStore.send(.initialize)
      case .retained:
        viewStore.send(.refetch)
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
