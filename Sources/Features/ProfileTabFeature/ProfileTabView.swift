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
    
    UIScrollView.appearance().bounces = false
  }
  
  var body: some View {
    
    VStack(spacing: 0) {
      HeaderView(type: .titleOnly(title: "MY"))
      
      ScrollView(showsIndicators: false) {
        VStack(spacing: 0) {
          ProfileNicknameSection(
            isLogin: viewStore.isLogin,
            user: viewStore.user,
            onTapped: {
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
              viewStore.send(.tappedFAQ)
            })
          .padding(.top, 16)
          
          ProfilePolicySection(
            onServiceTapped: {
              viewStore.send(.tappedTermsOfService)
            }, onPrivacyTapped: {
              viewStore.send(.tappedPrivacyPolicy)
            }, onLocationTapped: {
              viewStore.send(.tappedLocationPrivacy)
            })
          .padding(.top, 16)
          
          ProfileVersionSection(version: viewStore.appVersion)
            .padding(.top, 16)
          
          if TokenManager.shared.isLogin {
            ProfileLoginSection(
              onLogoutTapped: {
                viewStore.send(.showAlert(.logout))
              }, onWithdrawTapped: {
                viewStore.send(.tappedWithdraw)
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
    .sheet(item: viewStore.binding(
      get: \.showWeb,
      send: ProfileTabFeature.Action.dismissWeb
    )) { web in
      SafariView(url: {
        switch web {
        case let .faq(url), let .termsOfService(url), let .privacyPolicy(url), let .locationPrivacy(url):
          return url
        }
      }())
    }
  }
}
