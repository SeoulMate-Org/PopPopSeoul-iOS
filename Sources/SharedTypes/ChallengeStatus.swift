//
//  MyChallengeType.swift
//  SharedTypes
//
//  Created by suni on 4/25/25.
//

import Foundation

public enum ChallengeStatus: String, Equatable, CaseIterable {
  case progress
  case completed
  
 public var apiCode: String {
    switch self {
    case .progress: return "PROGRESS"
    case .completed: return "COMPLETE"
    }
  }
  
  public static func from(apiCode: String?) -> ChallengeStatus? {
    guard let apiCode else { return nil }
    return Self.allCases.first { $0.apiCode == apiCode }
  }
}
