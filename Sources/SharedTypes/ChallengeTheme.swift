//
//  ChallengeTheme.swift
//  Clients
//
//  Created by suni on 4/24/25.
//

import Foundation

public enum ChallengeTheme: Int, CaseIterable, Identifiable {
  case localExploration
  case historyCulture
  case artExhibition
  case gourmetAndLegacy
  case nightscapeAndMood
  case walkingTour
  case photoTour
  case mustVisit
  case culturalEvent
  
  public var id: Int { rawValue }
  
  public var title: String {
    switch self {
    case .localExploration: return "지역 탐방"
    case .historyCulture: return "역사 & 문화"
    case .artExhibition: return "전시 & 예술"
    case .gourmetAndLegacy: return "미식 & 오래가게"
    case .nightscapeAndMood: return "야경 & 감성"
    case .walkingTour: return "도보 여행"
    case .photoTour: return "포토 투어"
    case .mustVisit: return "핵심 관광지 정복"
    case .culturalEvent: return "문화 행사 연계"
    }
  }
}
