//
//  PutCommentRequest.swift
//  Clients
//
//  Created by suni on 4/27/25.
//

import Foundation
import Common

public struct PutCommentRequest: Encodable {
  public init(
    comment: String,
    challengeId: Int
  ) {
    self.comment = comment
    self.challengeId = challengeId
  }

  public let comment: String
  public let challengeId: Int
  public let languageCode: String = AppSettingManager.shared.language.apiCode

  enum CodingKeys: CodingKey {
    case comment
    case challengeId
    case languageCode
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(comment, forKey: .comment)
    try container.encode(challengeId, forKey: .challengeId)
    try container.encode(languageCode, forKey: .languageCode)
  }
}
