//
//  Token.swift
//  Models
//
//  Created by suni on 4/25/25.
//

import Foundation

public struct Token: Hashable {
  public var accessToken: String
  public var refreshToken: String
  
  public init(accessToken: String, refreshToken: String) {
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }
}

extension Token: Codable {
  
  private enum CodingKeys: String, CodingKey {
    case accessToken
    case refreshToken
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    try accessToken = container.decode(String.self, forKey: .accessToken)
    try refreshToken = container.decode(String.self, forKey: .refreshToken)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(accessToken, forKey: .accessToken)
    try container.encode(refreshToken, forKey: .refreshToken)
  }
}
