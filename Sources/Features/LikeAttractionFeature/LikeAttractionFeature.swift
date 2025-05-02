//
//  LikeAttractionFeature.swift
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
public struct LikeAttractionFeature {
  
  @Dependency(\.myClient) var myClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    var badges: [Attraction] = []
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onApear
    case fetch
    case update([Attraction])
    case networkError
    case tappedBack
    case tappedAttraction(Int)
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
            let result = try await myClient.fetchAttractions()
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
        
      case .tappedAttraction:
        return .none
      }
    }
  }
}

// MARK: - Helper
