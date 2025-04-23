//
//  ChallengeTheme.swift
//  Clients
//
//  Created by suni on 4/24/25.
//

import Foundation

public enum ChallengeTheme: String, CaseIterable, Identifiable {
  case localExploration = "지역 탐방"
  case historyCulture = "역사 & 문화"
  case artExhibition = "전시 & 예술"
  case gourmetAndLegacy = "미식 & 오래가게"
  case nightscapeAndMood = "야경 & 감성"
  case walkingTour = "도보 여행"
  case photoTour = "포토 투어"
  case mustVisit = "핵심 관광지 정복"
  case culturalEvent = "문화 행사 연계"
  
  public var id: String { rawValue }
  
  public var title: String {
    return rawValue
  }
}
