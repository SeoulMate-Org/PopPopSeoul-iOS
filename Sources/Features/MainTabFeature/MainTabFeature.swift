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
    
    var myChallenge: MyChallengeTabFeature.State = .init()
    var home: HomeTabFeature.State = .init()
    
    var showLoginAlert: Bool = false
    
    var path = StackState<Path.State>()
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case selectedTabChanged(State.Tab)
    
    case myChallenge(MyChallengeTabFeature.Action)
    case home(HomeTabFeature.Action)
    
    case loginAlert(LoginAlertAction)
    case successLogin(isNewUser: Bool)
    
    case path(StackActionOf<Path>)
  }
  
  public enum LoginAlertAction {
    case cancelTapped
    case loginTapped
  }
  
  // MARK: Reducer
  
  public var body: some Reducer<State, Action> {
    Scope(state: \.myChallenge, action: \.myChallenge) {
      MyChallengeTabFeature()
    }
    
    Scope(state: \.home, action: \.home) {
      HomeTabFeature()
    }
    
    Reduce { state, action in
      switch action {
      case .selectedTabChanged(let tab):
        if tab == .myChallenge && !TokenManager.shared.isLogin {
          // 로그인 체크
          state.showLoginAlert = true
        } else {
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
        
        // MARK: - Path Reducer
      case let .path(action):
        switch action {
          // move to detail comments
        case .element(id: _, action: .detailChallenge(.tappedAllComments(let id))):
          state.path.append(.detailComments(DetailCommentsFeature.State(with: id)))
          return .none
          
        case let .element(id: _, action: .detailChallenge(.tappedEditComment(id, comment))):
          state.path.append(.detailComments(DetailCommentsFeature.State(with: id, comment)))
          return .none
          
          // move to detail attraction
        case .element(id: _, action: .detailChallenge(.tappedAttraction(let id))),
            .element(id: _, action: .attractionMap(.tappedDetail(let id))):
          state.path.append(.detailAttraction(DetailAttractionFeature.State(with: id)))
          return .none

        case .element(id: _, action: .detailChallenge(.moveToMap(let challenge))):
          state.path.append(.attractionMap(AttractionMapFeature.State(with: challenge)))
          return .none
          
          // move to login
        case .element(id: _, action: .detailChallenge(.showLoginAlert)),
            .element(id: _, action: .themeChallenge(.showLoginAlert)),
            .element(id: _, action: .detailAttraction(.showLoginAlert)),
            .element(id: _, action: .attractionMap(.showLoginAlert)):
          state.showLoginAlert = true
          return .none
          
        case let .element(id: _, action: .login(.successLogin(isNewUser))):
          return .send(.successLogin(isNewUser: isNewUser))
          
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
  }
  
}
