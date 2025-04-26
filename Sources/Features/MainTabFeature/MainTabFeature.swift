//
//  MainTabFeature.swift
//  SeoulMateKit
//
//  Created by suni on 4/2/25.
//

import Foundation
import ComposableArchitecture

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
        state.selectedTab = tab
        return .none
        
      case .loginAlert(.cancelTapped):
        state.showLoginAlert = false
        return .none
        
      case .loginAlert(.loginTapped):
        state.showLoginAlert = false
        // TODO: - 로그인 화면 이동
        return .none
        
      case .myChallenge(.tappedItem(let id)):
        state.path.append(.detail(DetailChallengeFeature.State(with: id)))
        return .none
        
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
    case detail(DetailChallengeFeature)
    case challengeMap(DetailChallengeFeature)
    case detailAttraction(DetailChallengeFeature)
  }
  
}
