//
//  StampChallenge.swift
//  SharedTypes
//
//  Created by suni on 5/1/25.
//

import Foundation

public enum StampChallenge: String, Equatable, CaseIterable {
  case missed
  case challenge
  case place
  
  public var apiCode: String {
    switch self {
    case .missed: return "MISSED"
    case .challenge: return "CAHLLENGE"
    case .place: return "PLACE"
    }
  }
  
  public static func from(apiCode: String?) -> StampChallenge? {
    guard let apiCode else { return nil }
    return Self.allCases.first { $0.apiCode == apiCode }
  }
}
