//
//  PostAuthRefreshRequest.swift
//  Models
//
//  Created by suni on 4/25/25.
//

import Foundation
import Common

public struct PostAuthRefreshRequest: Encodable {
  public init(
    refreshToken: String
  ) {
    self.refreshToken = refreshToken
  }

  public let refreshToken: String

  enum CodingKeys: CodingKey {
    case refreshToken
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(refreshToken, forKey: .refreshToken)
  }
}
