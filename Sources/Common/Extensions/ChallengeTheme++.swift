//
//  ChallengeTheme++.swift
//  Common
//
//  Created by suni on 5/3/25.
//

import Foundation
import SharedTypes

public extension ChallengeTheme {
  var title: String {
      switch self {
      case .localTour: return L10n.categoryName_local
      case .culturalEvent: return L10n.categoryName_culturalEvent
      case .mustSeeSpots: return L10n.categoryName_mustSeeSpots
      case .photoSpot: return L10n.categoryName_photoSpots
      case .walkingTour: return L10n.categoryName_walkingTours
      case .nightViewsMood: return L10n.categoryName_nightViews
      case .foodieHiddenGemes: return L10n.categoryName_foodie
      case .exhibitionArt: return L10n.categoryName_art
      case .historyCulture: return L10n.categoryName_history
      }
  }
}
