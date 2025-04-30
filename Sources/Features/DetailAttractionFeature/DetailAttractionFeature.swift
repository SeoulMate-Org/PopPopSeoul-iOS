//
//  DetailAttractionFeature.swift
//  Features
//
//  Created by suni on 4/29/25.
//

import Foundation
import ComposableArchitecture
import ComposableCoreLocation
import Common
import SharedTypes
import Models
import Clients

@Reducer
public struct DetailAttractionFeature {
  
  @Dependency(\.attractionClient) var attractionClient
  @Dependency(\.naverMapsClient) var naverMapsClient
  @Dependency(\.locationClient) var locationClient
  
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
    case fetchMap(Coordinate?)
    case updateMap(Data)
    
    case tappedBack
    case tappedLike
    case tappedNaverMap
    
    // Location
    case requestLocation
    case locationResult(LocationResult)
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
            await send(.fetchMap(attraction.coordinate))
            await send(.requestLocation)
          } catch {
            await send(.getError)
          }
        }
        
      case let .update(attraction):
        state.attraction = attraction
        return .none
        
      case let .fetchMap(coordinate):
        if let coordinate {
          return .run { send in
            do {
              let param = StaticMapParameters(
                markers: [
                  .init(position: (coordinate.latitude, coordinate.longitude))
                ]
              )
              let data = try await naverMapsClient.send(.staticMap(param))
              await send(.updateMap(data))
            } catch {
              await send(.getMapError)
            }
          }
        } else {
          return .send(.getMapError)
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
            update.likes = max(0, update.likes + (update.isLiked ? 1 : -1))
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
        if let attraction = state.attraction,
            let latitude = attraction.latitude,
            let longitude = attraction.longitude {
          Utility.openInNaveMap(lat: latitude, lng: longitude, name: attraction.name)
        }
        return .none
        
      case .requestLocation:
        return .run { send in
          let result = await locationClient.getCurrentLocation()
          await send(.locationResult(result))
        }
        
      case let .locationResult(.success(coordinate)):
        if let from = state.attraction?.coordinate {
          state.attraction?.distance = coordinate.distanceFormatted(from: from)
        }
        return .none
        
      default: return .none
      }
    }
  }
}

// MARK: - Helper
