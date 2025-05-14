//
//  ChallengeComment.swift
//  Models
//
//  Created by suni on 4/26/25.
//

import Foundation
import SharedTypes
import Common

public struct Comment: Identifiable, Hashable, Equatable {
  public var id: Int {
    return commentId
  }
  public let commentId: Int
  public let comment: String
  public let nickname: String
  public let isMine: Bool
  public let challengeId: Int
  public let createdAt: String
  public var created: String {
    return createdAt.toCommentDateString()
  }
  public let challengeStatusCode: String
  public var challengeStatus: ChallengeStatus? {
    ChallengeStatus.from(apiCode: challengeStatusCode)
  }

  public init(
    commentId: Int,
    comment: String,
    nickname: String,
    isMine: Bool,
    challengeId: Int,
    createdAt: String,
    challengeStatusCode: String
  ) {
    self.commentId = commentId
    self.comment = comment
    self.nickname = nickname
    self.isMine = isMine
    self.challengeId = challengeId
    self.createdAt = createdAt
    self.challengeStatusCode = createdAt
  }
}
extension Comment: Codable {
  
  private enum CodingKeys: String, CodingKey {
    case commentId
    case comment
    case nickname
    case isMine
    case challengeId
    case createdAt
    case challengeStatusCode
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    commentId = try container.decode(Int.self, forKey: .commentId)
    comment = try container.decodeIfPresent(String.self, forKey: .comment) ?? ""
    nickname = try container.decodeIfPresent(String.self, forKey: .nickname) ?? ""
    isMine = try container.decodeIfPresent(Bool.self, forKey: .isMine) ?? false
    challengeId = try container.decode(Int.self, forKey: .challengeId)
    createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
    challengeStatusCode = try container.decodeIfPresent(String.self, forKey: .challengeStatusCode) ?? ""
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(commentId, forKey: .commentId)
    try container.encodeIfPresent(comment, forKey: .comment)
    try container.encodeIfPresent(nickname, forKey: .nickname)
    try container.encodeIfPresent(isMine, forKey: .isMine)
    try container.encode(challengeId, forKey: .challengeId)
    try container.encodeIfPresent(createdAt, forKey: .createdAt)
    try container.encodeIfPresent(challengeStatusCode, forKey: .challengeStatusCode)
  }
}
