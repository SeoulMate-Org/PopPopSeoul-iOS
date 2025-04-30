//
//  DetailAttractionFeature.swift
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
public struct DetailAttractionFeature {
  
  @Dependency(\.attractionClient) var attractionClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    let attractionId: Int
    var attraction: Attraction?
    
    public init(with id: Int) {
      self.attractionId = id
    }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onApear
    case update(Attraction)
    case getError
    case showLoginAlert
    
    case tappedBack
    case tappedLike
    case tappedCopyAddress
    case tappedCall
    case tappedNaverMap
  }
  
  // MARK: Reducer
  @Dependency(\.dismiss) var dismiss
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onApear:
        return .run { [state = state] send in
          do {
            let id = state.attractionId
            let attraction = try await attractionClient.get(id)
            await send(.update(attraction))
          } catch {
            await send(.getError)
          }
        }
        
      case .tappedBack:
        return .run { _ in
          await self.dismiss()
        }
        
      case let .update(attraction):
        state.attraction = attraction
        return .none
        
      case .getError:
        // TODO: ERROR 처리
        return .none
        
      case .tappedLike:
        if TokenManager.shared.isLogin {
          return .run { [state = state] send in
            guard let attraction = state.attraction else { return }
            
            // 1. 좋아요 UI 즉시 업데이트
            var update = attraction
            update.isLiked.toggle()
            update.likes += update.isLiked ? 1 : -1
            await send(.update(update))
            
            do {
              let response = try await attractionClient.putLike(update.id)
              
              // 필요시 서버 데이터랑 다르면 다시 fetch
              if response.isLiked != update.isLiked {
                let fresh = try await attractionClient.get(response.id)
                await send(.update(fresh))
              }
            } catch {
              await send(.getError)
            }
          }
        } else {
          return .send(.showLoginAlert)
        }
        
      default: return .none
      }
    }
  }
}

// MARK: - Helper

