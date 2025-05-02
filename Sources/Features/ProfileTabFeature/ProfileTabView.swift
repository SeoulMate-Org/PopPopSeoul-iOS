//
//  ProfileTabView.swift
//  PopPopSeoulKit
//
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import Common
import SharedAssets
import Clients

struct ProfileTabView: View {
  let store: StoreOf<ProfileTabFeature>
  @ObservedObject var viewStore: ViewStore<ProfileTabFeature.State, ProfileTabFeature.Action>
  
  init(store: StoreOf<ProfileTabFeature>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
    
    VStack(spacing: 0) {
      HeaderView(type: .titleOnly(title: "MY"))
      
      ScrollView(showsIndicators: false) {
        VStack(spacing: 0) {
          ProfileNicknameSection(user: viewStore.user, onTapped: {
            viewStore.send(.tappedNickname)
          })
          
          ProfileCountView(
            user: viewStore.user,
            onbadgeTapped: {
              viewStore.send(.tappedLoginCheckMove(.badge))
            }, onLikeTapped: {
              viewStore.send(.tappedLoginCheckMove(.likeAttraction))
            }, onCommentTapped: {
              viewStore.send(.tappedLoginCheckMove(.comment))
            })
          
          ProfileSettingSection(
            language: viewStore.language.title,
            isLocationAuth: viewStore.binding(
              get: \.isLocationAuth,
              send: ProfileTabFeature.Action.toggleLocationAuth
            ),
            onLanguageTapped: {
              viewStore.send(.move(.language(viewStore.language)))
            }, onNotiTapped: {
              viewStore.send(.move(.notification))
            }, onLocationTapped: { isOn in
              viewStore.send(.toggleLocationAuth(isOn))
            })
          .padding(.top, 16)
          
          ProfileServiceSection(
            onOnboardingTapped: {
              viewStore.send(.move(.onboarding))
            }, onFAQTapped: {
              viewStore.send(.moveWeb(.faq))
            })
          .padding(.top, 16)
          
          ProfilePolicySection(
            onServiceTapped: {
              viewStore.send(.moveWeb(.termsOfService))
            }, onPrivacyTapped: {
              viewStore.send(.moveWeb(.privacyPolicy))
            }, onLocationTapped: {
              viewStore.send(.moveWeb(.locationPrivacy))
            })
          .padding(.top, 16)
          
          ProfileVersionSection(version: viewStore.appVersion)
            .padding(.top, 16)
          
          if TokenManager.shared.isLogin {
            ProfileLoginSection(
              onLogoutTapped: {
                viewStore.send(.showAlert(.logout))
              }, onWithdrawTapped: {
                viewStore.send(.move(.withdraw))
              })
            .padding(.top, 16)
          }
        }
        .padding(.bottom, 34)
      }
      .background(Colors.gray25.swiftUIColor)
    }
    .onAppear {
      viewStore.send(.initialize)
    }
  }
}
