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
    let isInit: Bool
    
    public init(isInit: Bool) {
      self.isInit = isInit
    }
    
    var currentPage: Int = 0
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case didFinish
    
    case tappedNext
    case setCurrentPage(Int)
  }
  
  // MARK: Reducer
  @Dependency(\.dismiss) var dismiss
  public var body: some Reducer<State, Action> {
    
    Reduce { state, action in
      switch action {
      case .didFinish:
        if state.isInit {
          return .none
        } else {
          return .run { _ in
            await self.dismiss()
          }
        }
      case .tappedNext:
        if state.currentPage > 2 {
          return .send(.didFinish)
        } else {
          state.currentPage += 1
          return .none
        }
      case let .setCurrentPage(page):
        state.currentPage = page
        return .none
        
      }
    }
  }
}

// MARK: - Helper
