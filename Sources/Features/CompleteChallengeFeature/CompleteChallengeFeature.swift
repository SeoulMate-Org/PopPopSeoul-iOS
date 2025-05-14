//
//  CompleteChallengeFeature.swift
//  Features
//
//  Created by suni on 5/1/25.
//

import Foundation
import ComposableArchitecture
import Common
import SharedTypes
import Models
import Clients

@Reducer
public struct CompleteChallengeFeature {
    
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    let theme: ChallengeTheme
    
    public init(with theme: ChallengeTheme) {
      self.theme = theme
    }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onApear
    
    case tappedDone
    case moveToBadge
  }
  
  // MARK: Reducer
  @Dependency(\.dismiss) var dismiss
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onApear:
        return .none
        
      case .tappedDone:
        return .run { _ in
          await self.dismiss()
        }
        
      case .moveToBadge:
        // TODO: - 마이 배지로 이동
        return .none
      }
    }
  }
}

// MARK: - Helper
