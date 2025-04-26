//
//  PostAuthLoginFbIosRequest.swift
//  Common
//
//  Created by suni on 4/26/25.
//

import Foundation
import Common

public struct PostAuthLoginFbIosRequest: Encodable {
  public init(
    email: String,
    languageCode: String
  ) {
    self.email = email
    self.languageCode = languageCode
  }

  public let email: String
  public let languageCode: String

  enum CodingKeys: CodingKey {
    case email
    case languageCode
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(email, forKey: .email)
    try container.encode(languageCode, forKey: .languageCode)
  }
}
