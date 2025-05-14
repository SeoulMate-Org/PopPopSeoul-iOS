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
  @Dependency(\.attractionClient) var attractionClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    var attractions: [Attraction] = []
    
    var recentlyDeleted: Attraction? = nil
    var showUndoToast: Bool = false
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onApear
    case fetch
    case update([Attraction])
    case networkError
    
    case tappedBack
    case tappedDetail(Int)
    case tappedLike(Int)
    case undoLike
    case dismissToast
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
        
      case let .update(attractions):
        state.attractions = attractions
        return .none

      case .tappedBack:
        return .run { _ in
          await self.dismiss()
        }
        
      case .networkError:
        // TODO: ERROR 처리
        return .none
        
      case .tappedDetail:
        // Main Tap Navigation
        return .none
        
      case let .tappedLike(id):
        guard let index = state.attractions.firstIndex(where: { $0.id == id }) else { return .none }
        state.recentlyDeleted = state.attractions.remove(at: index)
        state.showUndoToast = true
        return .run { send in
          do {
            _ = try await attractionClient.putLike(id)
            try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
            await send(.dismissToast)
          } catch {
            await send(.networkError)
          }
        }
        
      case .undoLike:
        guard let attraction = state.recentlyDeleted else { return .none }
        state.attractions.insert(attraction, at: 0)
        state.recentlyDeleted = nil
        state.showUndoToast = false
        return .run { send in
          do {
            _ = try await attractionClient.putLike(attraction.id)
          } catch {
            await send(.networkError)
          }
        }
        
      case .dismissToast:
        state.showUndoToast = false
        return .none
      }
    }
  }
}

// MARK: - Helper
