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
  
  public func title(_ language: AppLanguage) -> String {
    if language == .kor {
      switch self {
      case .localTour: return "지역 탐방"
      case .culturalEvent: return "문화 행사"
      case .mustSeeSpots: return "핵심 관광지 정복"
      case .photoSpot: return "포토 스팟"
      case .walkingTour: return "도보 여행"
      case .nightViewsMood: return "야경 & 감성"
      case .foodieHiddenGemes: return "미식 & 오래가게"
      case .exhibitionArt: return "전시 & 예술"
      case .historyCulture: return "역사 & 문화"
      }
    } else {
      switch self {
      case .localTour: return "Local Tour"
      case .culturalEvent: return "Cultural Events"
      case .mustSeeSpots: return "Must-See Spots"
      case .photoSpot: return "Photo Spot"
      case .walkingTour: return "Walking Tour"
      case .nightViewsMood: return "Night Views & Mood"
      case .foodieHiddenGemes: return "Foodie & Hidden Gems"
      case .exhibitionArt: return "Exhibitions & Art"
      case .historyCulture: return "History & Culture"
      }
    }
  }
  
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
