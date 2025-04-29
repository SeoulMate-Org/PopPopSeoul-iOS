//
//  RankChallengeFeature.swift
//  Features
//
//  Created by suni on 4/29/25.
//

import Foundation
import ComposableArchitecture
import Common
import SharedTypes
import Models
import Clients

@Reducer
public struct RankChallengeFeature {
  
  @Dependency(\.callengeListClient) var callengeListClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    var rankList: [Challenge] = []
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onApear
    case showLoginAlert
    case networkError
    
    case tappedBack
    
    case fetchRankList
    case updateRankList([Challenge])
  }
  // MARK: Reducer
  @Dependency(\.dismiss) var dismiss
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onApear:
        return .send(.fetchRankList)
        
      case .tappedBack:
        return .run { _ in
          await self.dismiss()
        }
        
      case .fetchRankList:
        return .run { send in
          do {
            let list = try await callengeListClient.fetchRankList()
            await send(.updateRankList(list))
          } catch {
            await send(.networkError)
          }
        }
        
      case let .updateRankList(list):
        state.rankList = list
        return .none
        
      default: return .none
      }
    }
  }
}

// MARK: - Helper
