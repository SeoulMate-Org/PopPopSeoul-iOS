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
  @Dependency(\.naverMapsClient) var naverMapsClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    let attractionId: Int
    var attraction: Attraction?
    var map: Data?
    
    public init(with id: Int) {
      self.attractionId = id
    }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onApear
    case getError
    case getMapError
    case showLoginAlert
    
    case update(Attraction)
    case fetchMap(Attraction)
    case updateMap(Data)
    
    case tappedBack
    case tappedLike
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
            await send(.fetchMap(attraction))
          } catch {
            await send(.getError)
          }
        }
        
      case let .update(attraction):
        state.attraction = attraction
        return .none
        
      case let .fetchMap(attraction):
        return .run { send in
          do {
            let param = StaticMapParameters(
              markers: [
                .init(position: (attraction.locationY, attraction.locationX))
              ]
            )
            let data = try await naverMapsClient.send(.staticMap(param))
            await send(.updateMap(data))
          } catch {
            await send(.getMapError)
          }
        }
        
      case let .updateMap(data):
        state.map = data
        return .none
        
      case .tappedBack:
        return .run { _ in
          await self.dismiss()
        }
        
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
        
      case .tappedNaverMap:
        if let attraction = state.attraction {
          Utility.openInNaveMap(lat: attraction.locationY, lng: attraction.locationX, name: attraction.name)
        }
        return .none
        
      default: return .none
      }
    }
  }
}

// MARK: - Helper
