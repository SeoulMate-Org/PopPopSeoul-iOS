//
//  MapFeature.swift
//  Features
//
//  Created by suni on 4/30/25.
//

import Foundation
import ComposableArchitecture
import Common
import SharedTypes
import Models
import Clients

@Reducer
public struct AttractionMapFeature {
  
  @Dependency(\.attractionClient) var attractionClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    var showLoginAlert: Bool = false
    var challengeName: String
    var attractions: [Attraction]
    var showAttractions: [Attraction]
    var bottomSheetType: BottomSheetType = .expand
    
    public init(with challenge: Challenge) {
      self.attractions = challenge.attractions
      self.challengeName = challenge.name
      self.showAttractions = challenge.attractions
    }
  }
  
  public enum BottomSheetType: Equatable {
    case expand
    case fold
    case detail(attraction: Attraction)
    
    public var attraction: Attraction? {
      switch self {
      case .detail(let attraction): return attraction
      default: return nil
      }
    }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onApear
    case networkError
    case showLoginAlert
    case loginAlert(LoginAlertAction)
    case update(Attraction)
    
    case tappedAttraction(Int)
    case tappedBack
    case tappedDetail(Int)
    case tappedLike(Int)
    
    case updateBottomSheetType(BottomSheetType)
  }
  
  // MARK: Reducer
  @Dependency(\.dismiss) var dismiss
  public var body: some ReducerOf<Self> {
    
    Reduce { state, action in
      switch action {
      case .onApear:
        return .none
        
      case let .tappedAttraction(id):
        if let first = state.attractions.first(where: { $0.id == id }) {
          state.showAttractions = [first]
          state.bottomSheetType = .detail(attraction: first)
        }
        return .none
        
      case .tappedBack:
        switch state.bottomSheetType {
        case .detail:
          state.bottomSheetType = .expand
          state.showAttractions = state.attractions
          return .none
        default:
          return .run { _ in
            await self.dismiss()
          }
        }
        
      case let .updateBottomSheetType(type):
        state.bottomSheetType = type
        return .none
        
      case let .tappedLike(id):
        if TokenManager.shared.isLogin {
          return .run { [state = state] send in
            guard let attraction = state.attractions.first(where: { $0.id == id }) else { return }
            
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
              await send(.networkError)
            }
          }
        } else {
          return .send(.showLoginAlert)
        }
        
      case let .update(attraction):
        guard let index = state.attractions.firstIndex(where: { $0.id == attraction.id }) else { return .none }
        state.attractions[index] = attraction
        
        guard let index = state.showAttractions.firstIndex(where: { $0.id == attraction.id }) else { return .none }
        state.showAttractions[index] = attraction
        
        if state.bottomSheetType != .expand && state.bottomSheetType != .fold {
          state.bottomSheetType = .detail(attraction: attraction)
        }
        
        return .none
        
      case .showLoginAlert:
        state.showLoginAlert = true
        return .none
        
      case .loginAlert(.cancelTapped):
        state.showLoginAlert = false
        return .none
        
      case .loginAlert(.loginTapped):
        state.showLoginAlert = false
        return .none
        
      case .networkError:
        // TODO: - 네트워크 오류
        return .none
        
      case .tappedDetail:
        return .none
        
      }
    }
  }
}
