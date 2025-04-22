//
//  AuthLoginPostRequest.swift
//  Clients
//
//  Created by suni on 4/23/25.
//

import Foundation
import Common

public struct AuthLoginBody: Encodable {
  public init(
    token: String,
    loginType: String,
    languageCode: String
  ) {
    self.token = token
    self.loginType = loginType
    self.languageCode = languageCode
  }

  public let token: String
  public let loginType: String
  public let languageCode: String

  enum CodingKeys: CodingKey {
    case token
    case loginType
    case languageCode
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(token, forKey: .token)
    try container.encode(loginType, forKey: .loginType)
    try container.encode(languageCode, forKey: .languageCode)
  }
}
