//
//  MyBadge.swift
//  Features
//
//  Created by suni on 5/2/25.
//

import Foundation
import SharedTypes

public struct MyBadge: Hashable, Equatable, Identifiable {
  public var id: Int {
    return themeId
  }
  public let themeId: Int
  public let themeName: String
  public var theme: ChallengeTheme? {
    return ChallengeTheme(rawValue: themeId)
  }
  public let themeCount: Int
  public let completeCount: Int
  public let isCompleted: Bool

  public init(
    themeId: Int,
    themeName: String,
    themeCount: Int,
    completeCount: Int,
    isCompleted: Bool
  ) {
    self.themeId = themeId
    self.themeName = themeName
    self.themeCount = themeCount
    self.completeCount = completeCount
    self.isCompleted = isCompleted
  }
}

extension MyBadge: Codable {
  private enum CodingKeys: String, CodingKey {
    case themeId
    case themeName
    case themeCount
    case completeCount
    case isCompleted
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    themeId = try container.decode(Int.self, forKey: .themeId)
    themeName = try container.decodeIfPresent(String.self, forKey: .themeName) ?? ""
    themeCount = try container.decodeIfPresent(Int.self, forKey: .themeCount) ?? 0
    completeCount = try container.decodeIfPresent(Int.self, forKey: .completeCount) ?? 0
    isCompleted = try container.decodeIfPresent(Bool.self, forKey: .isCompleted) ?? false
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(themeId, forKey: .themeId)
    try container.encodeIfPresent(themeName, forKey: .themeName)
    try container.encodeIfPresent(themeCount, forKey: .themeCount)
    try container.encodeIfPresent(completeCount, forKey: .completeCount)
    try container.encodeIfPresent(isCompleted, forKey: .isCompleted)
  }
}
