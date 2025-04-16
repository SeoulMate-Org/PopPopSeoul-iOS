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
      case home, myPop, profile
    }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case homeTapped
    case myPopTapped
    case profileTapped
  }
  
  // MARK: Reducer
  
  public var body: some Reducer<State, Action> {
//    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .homeTapped:
        state.selectedTab = .home
        return .none
      case .myPopTapped:
        state.selectedTab = .myPop
        return .none
      case .profileTapped:
        state.selectedTab = .profile
        return .none
      }
    }
  }
}

// MARK: - Helper
