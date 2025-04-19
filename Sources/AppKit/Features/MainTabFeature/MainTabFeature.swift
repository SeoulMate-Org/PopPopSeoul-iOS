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
    
    var myPop: MyPopFeature.State = .init()
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case selectedTabChanged(State.Tab)
    
    case myPop(MyPopFeature.Action)
  }
  
  // MARK: Reducer
  
  public var body: some Reducer<State, Action> {    
    Scope(state: \.myPop, action: \.myPop) {
      MyPopFeature()
    }

    Reduce { state, action in
      switch action {
      case .selectedTabChanged(let tab):
        state.selectedTab = tab
        return .none
      default:
        return .none
      }
    }
  }
}

// MARK: - Helper
