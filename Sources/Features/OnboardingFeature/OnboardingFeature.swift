//
//  OnboardingFeature.swift
//  Clients
//
//  Created by suni on 4/22/25.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct OnboardingFeature {
  public init() {}
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case didFinish
  }
  
  // MARK: Reducer
  
  public var body: some Reducer<State, Action> {
    
    Reduce { state, action in
      switch action {
      case .didFinish:
        return .none
      }
    }
  }
}

// MARK: - Helper
