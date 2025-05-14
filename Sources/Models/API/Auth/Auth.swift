//
//  Auth.swift
//  Models
//
//  Created by suni on 4/23/25.
//

import Foundation

public struct Auth: Hashable {
  public let id: Int
  public let email: String
  public let nickname: String
  public let loginType: String
  public let isNewUser: Bool
  public var accessToken: String
  public var refreshToken: String

  public init(
    id: Int,
    email: String,
    nickname: String,
    loginType: String,
    isNewUser: Bool,
    accessToken: String,
    refreshToken: String
  ) {
    self.id = id
    self.email = email
    self.nickname = nickname
    self.loginType = loginType
    self.isNewUser = isNewUser
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }
}

extension Auth: Codable {

  private enum CodingKeys: String, CodingKey {
    case id
    case email
    case nickname
    case loginType
    case isNewUser
    case accessToken
    case refreshToken
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    try id = container.decode(Int.self, forKey: .id)
    try email = container.decode(String.self, forKey: .email)
    try nickname = container.decode(String.self, forKey: .nickname)
    try loginType = container.decode(String.self, forKey: .loginType)
    try isNewUser = container.decode(Bool.self, forKey: .isNewUser)
    try accessToken = container.decode(String.self, forKey: .accessToken)
    try refreshToken = container.decode(String.self, forKey: .refreshToken)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(email, forKey: .email)
    try container.encode(nickname, forKey: .nickname)
    try container.encode(loginType, forKey: .loginType)
    try container.encode(isNewUser, forKey: .isNewUser)
    try container.encode(accessToken, forKey: .accessToken)
    try container.encode(refreshToken, forKey: .refreshToken)
  }
}
