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
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
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
    
    case tappedAttraction(Int)
    case tappedBack
    
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
          return .none
        default:
          return .run { _ in
            await self.dismiss()
          }
        }
        
      case let .updateBottomSheetType(type):
        state.bottomSheetType = type
        return .none
      }
    }
  }
}
