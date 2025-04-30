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
    
    public init(with challenge: Challenge) {
      self.attractions = challenge.attractions
      self.challengeName = challenge.name
    }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onApear
    
    case tappedBack
  }
  
  // MARK: Reducer
  @Dependency(\.dismiss) var dismiss
  public var body: some ReducerOf<Self> {
    
    Reduce { state, action in
      switch action {
      case .onApear:
        return .none
        
      case .tappedBack:
        return .run { _ in
          await self.dismiss()
        }
      }
    }
  }
}
