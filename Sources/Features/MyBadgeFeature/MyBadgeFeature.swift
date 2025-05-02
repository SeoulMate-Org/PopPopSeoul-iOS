//
//  MyBadgeFeature.swift
//  Features
//
//  Created by suni on 5/2/25.
//

import Foundation
import ComposableArchitecture
import Common
import SharedTypes
import Models
import Clients

@Reducer
public struct MyBadgeFeature {
  
  @Dependency(\.myClient) var myClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    var badges: [MyBadge] = []
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onApear
    case fetch
    case update([MyBadge])
    case networkError
    case tappedBack
  }
  
  // MARK: Reducer
  @Dependency(\.dismiss) var dismiss
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        
      case .onApear:
        return .send(.fetch)
        
      case .fetch:
        return .run { send in
          do {
            let result = try await myClient.fetchBadges()
            await send(.update(result))
          } catch {
            await send(.networkError)
          }
        }
        
      case let .update(badges):
        state.badges = badges
        return .none

      case .tappedBack:
        return .run { _ in
          await self.dismiss()
        }
        
      case .networkError:
        // TODO: ERROR 처리
        return .none
      }
    }
  }
}

// MARK: - Helper
