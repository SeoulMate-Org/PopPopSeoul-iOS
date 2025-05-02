//
//  MainTabView.swift
//  SeoulMateKit
//
//  Created by suni on 4/2/25.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import Common
import SharedAssets

public struct MainTabView: View {
  @State private var store: StoreOf<MainTabFeature>
  
  public init(store: StoreOf<MainTabFeature>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
      WithViewStore(store, observe: { $0 }) { viewStore in
        VStack(spacing: 0) {
          Group {
            switch viewStore.selectedTab {
            case .home:
              HomeTabView(
                store: store.scope(
                  state: \.home,
                  action: \.home
                )
              )
            case .myChallenge:
              MyChallengeTabView(
                store: store.scope(
                  state: \.myChallenge,
                  action: \.myChallenge
                )
              )
            case .profile:
              ProfileTabView(
                store: store.scope(
                  state: \.profile,
                  action: \.profile
                )
              )
            }
          }
          .frame(maxHeight: .infinity)
          
          tabView(viewStore: viewStore)
        }
        .overlay(
          Group {
            if let showAlert = viewStore.showAlert {
              switch showAlert {
              case .login:
                AppLoginAlertView(onLoginTapped: {
                  viewStore.send(.alertAction(.login, true))
                }, onCancelTapped: {
                  viewStore.send(.alertAction(.login, false))
                })
              case .logout:
                AppAlertView(
                  title: "로그아웃할까요?",
                  message: "앱에서 로그아웃됩니다.",
                  primaryButtonTitle: "로그인",
                  primaryAction: {
                    viewStore.send(.alertAction(.logout, true))
                  },
                  secondaryButtonTitle: "취소",
                  secondaryAction: {
                    viewStore.send(.alertAction(.logout, false))
                  })
              case .onLocation:
                AppAlertView(
                  title: "위치 권한을 설정할까요?",
                  message: "챌린지 진행을 위해 위치 정보가 필요해요.",
                  primaryButtonTitle: "설정하러 가기",
                  primaryAction: {
                    viewStore.send(.alertAction(.onLocation, true))
                  },
                  secondaryButtonTitle: "취소",
                  secondaryAction: {
                    viewStore.send(.alertAction(.onLocation, false))
                  })
              case .offLocation:
                AppAlertView(
                  title: "위치 권한을 해제할까요?",
                  message: "챌린지 진행을 위해 위치 정보가 필요해요.",
                  primaryButtonTitle: "해제하러 가기",
                  primaryAction: {
                    viewStore.send(.alertAction(.offLocation, true))
                  },
                  secondaryButtonTitle: "나중에",
                  secondaryAction: {
                    viewStore.send(.alertAction(.offLocation, false))
                  })
              }
            }
          }
        )
      }
    } destination: { store in
      switch store.state {
      case .detailChallenge:
        if let store = store.scope(state: \.detailChallenge, action: \.detailChallenge) {
          DetailChallengeView(store: store)
        }
      case .detailComments:
        if let store = store.scope(state: \.detailComments, action: \.detailComments) {
          DetailCommentsView(store: store)
        }
      case .login:
        if let store = store.scope(state: \.login, action: \.login) {
          LoginView(store: store)
        }
      case .themeChallenge:
        if let store = store.scope(state: \.themeChallenge, action: \.themeChallenge) {
          ThemeChallengeView(store: store)
        }
      case .rankChallenge:
        if let store = store.scope(state: \.rankChallenge, action: \.rankChallenge) {
          RankChallengeView(store: store)
        }
      case .detailAttraction:
        if let store = store.scope(state: \.detailAttraction, action: \.detailAttraction) {
          DetailAtrractionView(store: store)
        }
      case .attractionMap:
        if let store = store.scope(state: \.attractionMap, action: \.attractionMap) {
          AttractionMapView(store: store)
        }
      case .completeChallenge:
        if let store = store.scope(state: \.completeChallenge, action: \.completeChallenge) {
          CompleteChallengeView(store: store)
        }
      case .myBadge:
        if let store = store.scope(state: \.myBadge, action: \.myBadge) {
          MyBadgeView(store: store)
        }
      case .likeAttraction:
        if let store = store.scope(state: \.likeAttraction, action: \.likeAttraction) {
          LikeAttractionView(store: store)
        }
      case .myComment:
        if let store = store.scope(state: \.myComment, action: \.myComment) {
          MyCommentView(store: store)
        }
      case .languageSetting:
        if let store = store.scope(state: \.languageSetting, action: \.languageSetting) {
          LanguageSettingView(store: store)
        }
      case .nicknameSetting:
        if let store = store.scope(state: \.nicknameSetting, action: \.nicknameSetting) {
          NicknameSettingView(store: store)
        }
      case .withdraw:
        if let store = store.scope(state: \.withdraw, action: \.withdraw) {
          WithdrawView(store: store)
        }
      case .onboarding:
        if let store = store.scope(state: \.onboarding, action: \.onboarding) {
          OnboardingView(store: store)
        }
      }
    }
  }
  
  @ViewBuilder
  private func tabView(viewStore: ViewStore<MainTabFeature.State, MainTabFeature.Action>) -> some View {
    VStack(spacing: 0) {
      Rectangle()
        .foregroundColor(Colors.gray25.swiftUIColor)
        .frame(height: 1)
      
      HStack {
        tabItem(tab: .home, isSelected: viewStore.selectedTab == .home) {
          store.send(.selectedTabChanged(.home))
        }
        
        tabItem(tab: .myChallenge, isSelected: viewStore.selectedTab == .myChallenge) {
          store.send(.selectedTabChanged(.myChallenge))
        }
        
        tabItem(tab: .profile, isSelected: viewStore.selectedTab == .profile) {
          store.send(.selectedTabChanged(.profile))
        }
      }
      .frame(height: 58)
      .background(Color(Colors.appWhite.swiftUIColor))
      .contentMargins(.horizontal, 20)
    }
    .background(
      Color(Colors.appWhite.swiftUIColor)
        .modifier(ShadowModifier(
          shadow: AppShadow(
            color: Color(Colors.trueBlack.swiftUIColor).opacity(0.08),
            x: 0,
            y: -4,
            blur: 12,
            spread: 0
          ))
        )
        .edgesIgnoringSafeArea(.bottom)
    )
  }
  
  @ViewBuilder
  private func tabItem(tab: MainTabFeature.State.Tab, isSelected: Bool, action: @escaping () -> Void) -> some View {
    
    let icon = isSelected ? tab.selectedIcon : tab.icon
    let label = tab.title
    let color = isSelected ? tab.selectedColor : tab.color
    
    VStack {
      Button(action: action) {
        VStack(spacing: 4) {
          icon
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(color)
          
          Text(label)
            .font(.pretendard(size: 12, weight: .semibold))
            .foregroundColor(color)
        }
      }
      .buttonStyle(PlainButtonStyle())
      .contentShape(Rectangle())
    }
    .frame(maxWidth: .infinity)
  }
}

// MARK: Preview

// MARK: - Helper

extension MainTabFeature.State.Tab {
  var color: Color {
    Color(Colors.gray300.swiftUIColor)
  }
  
  var selectedColor: Color {
    Color(Colors.blue500.swiftUIColor)
  }
  
  var title: String {
    switch self {
    case .home: String(sLocalization: .tabHome)
    case .myChallenge: String(sLocalization: .tabMychallenge)
    case .profile: String(sLocalization: .tabProfile)
    }
  }
  
  var icon: Image {
    switch self {
    case .home: Assets.Icons.homeLine.swiftUIImage
    case .myChallenge: Assets.Icons.popLine.swiftUIImage
    case .profile: Assets.Icons.profileLine.swiftUIImage
    }
  }
  
  var selectedIcon: Image {
    switch self {
    case .home: Assets.Icons.homeFill.swiftUIImage
    case .myChallenge: Assets.Icons.popFill.swiftUIImage
    case .profile: Assets.Icons.profileLine.swiftUIImage
    }
  }
}
