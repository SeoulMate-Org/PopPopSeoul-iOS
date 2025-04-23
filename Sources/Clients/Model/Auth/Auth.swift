//
//  AuthLoginPostResponse.swift
//  Clients
//
//  Created by suni on 4/23/25.
//

import Foundation

public struct Auth: Identifiable, Hashable {
  public var id = UUID()
  public let email: String
  public let nickname: String
  public var accessToken: String
  public var refreshToken: String

  public init(
    email: String,
    nickname: String,
    accessToken: String,
    refreshToken: String
  ) {
    self.email = email
    self.nickname = nickname
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }
}

extension Auth: Codable {

  private enum CodingKeys: String, CodingKey {
    case email
    case nickname
    case accessToken
    case refreshToken
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    try email = container.decode(String.self, forKey: .email)
    try nickname = container.decode(String.self, forKey: .nickname)
    try accessToken = container.decode(String.self, forKey: .accessToken)
    try refreshToken = container.decode(String.self, forKey: .refreshToken)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(email, forKey: .email)
    try container.encode(nickname, forKey: .nickname)
    try container.encode(accessToken, forKey: .accessToken)
    try container.encode(refreshToken, forKey: .refreshToken)
  }
}

public enum LoginType: String, Equatable {
  case google = "GOOGLE"
  case facebook = "FACEBOOK_IOS"
  case apple = "APPLE"
}
