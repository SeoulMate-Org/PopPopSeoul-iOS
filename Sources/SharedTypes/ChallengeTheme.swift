//
//  ChallengeTheme.swift
//  Clients
//
//  Created by suni on 4/24/25.
//

import Foundation

public enum ChallengeTheme: Int, CaseIterable, Identifiable, Equatable {
  case localTour = 1
  case culturalEvent
  case mustSeeSpots
  case photoSpot
  case walkingTour
  case nightViewsMood
  case foodieHiddenGemes
  case exhibitionArt
  case historyCulture
  
  public var id: Int { rawValue }
  
  public var priority: Int {
    switch self {
    case .mustSeeSpots: return 1
    case .localTour: return 2
    case .historyCulture: return 3
    case .walkingTour: return 4
    case .nightViewsMood: return 5
    case .photoSpot: return 6
    case .foodieHiddenGemes: return 7
    case .exhibitionArt: return 8
    case .culturalEvent: return 9
    }
  }
}

extension ChallengeTheme {
  public static func sortedByPriority() -> [ChallengeTheme] {
    Self.allCases.sorted { $0.priority < $1.priority }
  }
}
