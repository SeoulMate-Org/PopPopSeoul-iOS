//
//  MainTabFeature.swift
//  SeoulMateKit
//
//  Created by suni on 4/2/25.
//

import Foundation
import ComposableArchitecture
import Clients

@Reducer
public struct MainTabFeature {
  public init() {}
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    public var selectedTab: Tab = .home
    
    public enum Tab {
      case home, myChallenge, profile
    }
    
    var home: HomeTabFeature.State = .init()
    var myChallenge: MyChallengeTabFeature.State = .init()
    var profile: ProfileTabFeature.State = .init()
    
    var showLoginAlert: Bool = false
    
    var path = StackState<Path.State>()
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case selectedTabChanged(State.Tab)
    
    case home(HomeTabFeature.Action)
    case myChallenge(MyChallengeTabFeature.Action)
    case profile(ProfileTabFeature.Action)
    
    case loginAlert(LoginAlertAction)
    case successLogin(isNewUser: Bool)
    
    case path(StackActionOf<Path>)
  }
  
  // MARK: Reducer
  
  public var body: some Reducer<State, Action> {
    Scope(state: \.myChallenge, action: \.myChallenge) {
      MyChallengeTabFeature()
    }
    
    Scope(state: \.home, action: \.home) {
      HomeTabFeature()
    }
    
    Scope(state: \.profile, action: \.profile) {
      ProfileTabFeature()
    }
    
    Reduce { state, action in
      switch action {
      case .selectedTabChanged(let tab):
        switch tab {
        case .home:
          state.home.onAppearType = .tabReappeared
          state.selectedTab = tab
        case .myChallenge:
          if !TokenManager.shared.isLogin {
            state.showLoginAlert = true
          } else {
            state.selectedTab = tab
          }
        case .profile:
          state.profile.onAppearType = .tabReappeared
          state.selectedTab = tab
        }
        return .none
        
      case .loginAlert(.cancelTapped):
        state.showLoginAlert = false
        return .none
        
      case .loginAlert(.loginTapped):
        state.showLoginAlert = false
        state.path.append(.login(LoginFeature.State(isInit: false)))
        return .none
        
        // MARK: - My Challenge Reducer
      case .myChallenge(.tappedItem(let id)):
        state.path.append(.detailChallenge(DetailChallengeFeature.State(with: id)))
        return .none
        
        // MARK: - Home Reducer
      case .home(.showLoginAlert):
        state.showLoginAlert = true
        return .none
        
      case .home(.tappedChallenge(let id)):
        state.path.append(.detailChallenge(DetailChallengeFeature.State(with: id)))
        return .none
        
      case .home(.moveToThemeChallenge(let theme)):
        state.path.append(.themeChallenge(ThemeChallengeFeature.State(with: theme)))
        return .none
        
      case .home(.moveToRank):
        state.path.append(.rankChallenge(RankChallengeFeature.State()))
        return .none
        
        // MARK: - Profile Reducer
      case .profile(.move(let action)):
        switch action {
        case .nicknameSetting(_):
          return .none
          
        case .badge:
          state.path.append(.myBadge(MyBadgeFeature.State()))
          return .none
          
        case .likeAttraction:
          state.path.append(.likeAttraction(LikeAttractionFeature.State()))
          return .none
          
        case .comment:
          state.path.append(.myComment(MyCommentFeature.State()))
          return .none
          
        case .language(_):
          return .none
        case .notification:
          return .none
        case .onboarding:
          return .none
        case .withdraw:
          return .none
        }
        
        // MARK: - Path Reducer
      case let .path(action):
        switch action {
          // move to detail comments
        case let .element(id: _, action: .detailChallenge(.moveToAllComment(id, comment, isFocus))):
          state.path.append(.detailComments(DetailCommentsFeature.State(with: id, comment: comment, isFocus: isFocus)))
          return .none
          
          // move to detail attraction
        case .element(id: _, action: .detailChallenge(.tappedAttraction(let id))),
            .element(id: _, action: .attractionMap(.tappedDetail(let id))),
            .element(id: _, action: .likeAttraction(.tappedDetail(let id))):
          state.path.append(.detailAttraction(DetailAttractionFeature.State(with: id)))
          return .none
          
        case .element(id: _, action: .detailChallenge(.moveToMap(let challenge))):
          state.path.append(.attractionMap(AttractionMapFeature.State(with: challenge)))
          return .none
          
          // move to login
        case .element(id: _, action: .detailChallenge(.loginAlert(.loginTapped))),
            .element(id: _, action: .themeChallenge(.loginAlert(.loginTapped))),
            .element(id: _, action: .detailAttraction(.loginAlert(.loginTapped))),
            .element(id: _, action: .attractionMap(.loginAlert(.loginTapped))):
          state.path.append(.login(LoginFeature.State(isInit: false)))
          return .none
          
        case let .element(id: _, action: .login(.successLogin(isNewUser))):
          return .send(.successLogin(isNewUser: isNewUser))
          
          // move to detail challenge
        case .element(id: _, action: .themeChallenge(.tappedChallenge(let id))):
          state.path.append(.detailChallenge(DetailChallengeFeature.State(with: id)))
          return .none
          
          // move to complete challenge
        case .element(id: _, action: .detailChallenge(.showCompleteChallenge(let theme))):
          state.path.append(.completeChallenge(CompleteChallengeFeature.State(with: theme)))
          return .none
          
          // move to home
        case .element(id: _, action: .myComment(.moveToHome)):
          state.path.removeAll()
          state.home.onAppearType = .tabReappeared
          state.selectedTab = .home
          return .none
          
        default:
          return .none
        }
        
      default:
        return .none
      }
    }
    .forEach(\.path, action: \.path)
  }
}

// MARK: - Helper
extension MainTabFeature {
  
  @Reducer(state: .equatable, action: .equatable)
  public enum Path {
    case detailChallenge(DetailChallengeFeature)
    case detailComments(DetailCommentsFeature)
    case login(LoginFeature)
    case themeChallenge(ThemeChallengeFeature)
    case rankChallenge(RankChallengeFeature)
    case detailAttraction(DetailAttractionFeature)
    case attractionMap(AttractionMapFeature)
    case completeChallenge(CompleteChallengeFeature)
    case myBadge(MyBadgeFeature)
    case likeAttraction(LikeAttractionFeature)
    case myComment(MyCommentFeature)
  }
  
}

public enum LoginAlertAction: Equatable {
  case cancelTapped
  case loginTapped
}

public enum OnAppearType: Equatable {
  case firstTime
  case tabReappeared
  case retained
}
