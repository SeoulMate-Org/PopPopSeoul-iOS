//
//  User.swift
//  Models
//
//  Created by suni on 5/2/25.
//

import Foundation
import SharedTypes

public struct User: Hashable, Equatable {
  public let id: Int
  public let email: String
  public let nickname: String
  public let loginType: String
  public var appLoginType: AppLoginType {
    return AppLoginType(rawValue: loginType) ?? .none
  }
  public let badgeCount: Int
  public let likedCount: Int
  public let commentCount: Int
  
  public init(id: Int, email: String, nickname: String, loginType: String, badgeCount: Int, likedCount: Int, commentCount: Int) {
    self.id = id
    self.email = email
    self.nickname = nickname
    self.loginType = loginType
    self.badgeCount = badgeCount
    self.likedCount = likedCount
    self.commentCount = commentCount
  }
}

extension User: Codable {
  private enum CodingKeys: String, CodingKey {
    case id
    case email
    case nickname
    case loginType
    case badgeCount
    case likedCount
    case commentCount
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    id = try container.decode(Int.self, forKey: .id)
    email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
    nickname = try container.decodeIfPresent(String.self, forKey: .nickname) ?? ""
    loginType = try container.decodeIfPresent(String.self, forKey: .loginType) ?? ""
    badgeCount = try container.decodeIfPresent(Int.self, forKey: .badgeCount) ?? 0
    likedCount = try container.decodeIfPresent(Int.self, forKey: .likedCount) ?? 0
    commentCount = try container.decodeIfPresent(Int.self, forKey: .commentCount) ?? 0
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(id, forKey: .id)
    try container.encodeIfPresent(email, forKey: .email)
    try container.encodeIfPresent(nickname, forKey: .nickname)
    try container.encodeIfPresent(loginType, forKey: .loginType)
    try container.encodeIfPresent(badgeCount, forKey: .badgeCount)
    try container.encodeIfPresent(likedCount, forKey: .likedCount)
    try container.encodeIfPresent(commentCount, forKey: .commentCount)
  }
}
