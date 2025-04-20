//
//  ChallengeDetailFeature.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct ChallengeDetailFeature {
  public init() {}
  
  // MARK: State

  @ObservableState
  public struct State: Equatable {
    public var challenge: Challenge
    public var showMenu: Bool = false
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    
  }
  
  // MARK: Reducer
  
  
}

// MARK: - Helper
