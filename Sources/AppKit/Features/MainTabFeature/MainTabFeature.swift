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
    public var selectedTab: Tab = .theme

    public enum Tab {
      case theme, map, likes
    }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case themeTapped
    case mapTapped
    case likesTapped
  }
  
  // MARK: Reducer
  
  public var body: some Reducer<State, Action> {
//    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .themeTapped:
        state.selectedTab = .theme
        return .none
      case .mapTapped:
        state.selectedTab = .map
        return .none
      case .likesTapped:
        state.selectedTab = .likes
        return .none
      }
    }
  }
}

// MARK: - Helper
