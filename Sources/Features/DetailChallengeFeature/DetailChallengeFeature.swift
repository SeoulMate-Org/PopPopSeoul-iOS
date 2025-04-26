//
//  DetailChallengeFeature.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import Foundation
import ComposableArchitecture
import Common
import SharedTypes
import Models

@Reducer
public struct DetailChallengeFeature {
  
  @Dependency(\.detailChallengeClient) var detailChallengeClient
    
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    let challengeId: Int
    var challenge: DetailChallenge?
    var showMenu: Bool = false
    
    public init(with id: Int) {
      self.challengeId = id
    }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onApear
    case update(DetailChallenge)
    case tappedBack
    case tappedMore
    case dismissMenu
    case quitChallenge
    case getError
  }
  
  // MARK: Reducer
  @Dependency(\.dismiss) var dismiss
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onApear:
        
        return .run { send in
          do {
            let challenge = try await detailChallengeClient.get(1)
            await send(.update(challenge))
          } catch {
            await send(.getError)
          }
        }
        
      case .tappedBack:
        return .run { _ in
            await self.dismiss()
        }
        
      case .tappedMore:
        state.showMenu = true
        return .none
        
      case .dismissMenu:
        state.showMenu = false
        return .none
        
      case .quitChallenge:
        // TODO: 챌린지 그만두기 API 호출
        state.showMenu = false
        return .none
        
      case let .update(challenge):
        state.challenge = challenge
        return .none
        
      case .getError:
        // TODO: ERROR 처리
        return .none
      }
    }
  }
}

// MARK: - Helper
