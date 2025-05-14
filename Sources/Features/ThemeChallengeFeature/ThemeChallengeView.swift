//
//  ThemeChallengeView.swift
//  Features
//
//  Created by suni on 4/29/25.
//

import SwiftUI
import ComposableArchitecture
import Common
import DesignSystem
import SharedAssets
import Clients

struct ThemeChallengeView: View {
  let store: StoreOf<ThemeChallengeFeature>
  @ObservedObject var viewStore: ViewStore<ThemeChallengeFeature.State, ThemeChallengeFeature.Action>
  
  init(store: StoreOf<ThemeChallengeFeature>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      HeaderView(type: .back(title: L10n.detailmenuItem_themeChallenge, onBack: {
        viewStore.send(.tappedBack)
      }))
      
      ThemeChallengeTabView(
        selectedTab: viewStore.binding(
          get: \.selectedTheme,
          send: ThemeChallengeFeature.Action.themeChanged
        ),
        themeTabChanged: { tab in
          viewStore.send(.themeChanged(tab))
        })
            
      // MARK: - 리스트
      if viewStore.themeChallenges.count > 0 {
        ThemeChallengeListView(
          loginTapped: viewStore.isLogin ? nil : { viewStore.send(.showAlert(.login)) },
          challenges: viewStore.themeChallenges,
          onTapped: { id in
            viewStore.send(.tappedChallenge(id))
          },
          onLikeTapped: { id in
            viewStore.send(.tappedLike(id))
          },
          shouldScrollToTop: viewStore.binding(
            get: \.shouldScrollToTop,
            send: ThemeChallengeFeature.Action.setShouldScrollToTop)
        )
      } else {
        Spacer()
      }
    }
    .overlay(
      Group {
        if let alert = viewStore.showAlert {
          switch alert {
          case .login:
            AppLoginAlertView(onLoginTapped: {
              viewStore.send(.loginAlert(.loginTapped))
            }, onCancelTapped: {
              viewStore.send(.loginAlert(.cancelTapped))
            })
          }
        }
      }
    )
    .onAppear {
      viewStore.send(.onApear)
    }
    .navigationBarBackButtonHidden(true)
  }
}
