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

struct ProfileTabView: View {
  let store: StoreOf<ProfileTabFeature>
  @ObservedObject var viewStore: ViewStore<ProfileTabFeature.State, ProfileTabFeature.Action>
  
  public init(store: StoreOf<ProfileTabFeature>) {
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
              
            }, onLikeTapped: {
              
            }, onCommentTapped: {
              
            })
          
          ProfileSettingSection(
            language: viewStore.language.title,
            isLocationAuth: viewStore.binding(
              get: \.isLocationAuth,
              send: ProfileTabFeature.Action.locationAuthToggle
            ),
            onLanguageTapped: {
              
            }, onNotiTapped: {
              
            }, onLocationTapped: { _ in
              
            })
          .padding(.top, 16)
        }
      }
      .background(Colors.gray25.swiftUIColor)
    }
    .onAppear {
      viewStore.send(.initialize)
    }
  }
}
