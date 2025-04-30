//
//  DefaultStatusResponse.swift
//  PopPopSeoul
//
//  Created by suni on 5/1/25.
//

import Foundation
import SharedTypes

public struct DefaultStatusResponse: Hashable, Equatable {
  public let id: Int
  public let challengeStatusCode: String
  public var challengeStatus: ChallengeStatus? {
    ChallengeStatus.from(apiCode: challengeStatusCode)
  }
  
  public init(id: Int, challengeStatusCode: String) {
    self.id = id
    self.challengeStatusCode = challengeStatusCode
  }
}

extension DefaultStatusResponse: Codable {
  private enum CodingKeys: String, CodingKey {
    case id
    case challengeStatusCode
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
    challengeStatusCode = try container.decodeIfPresent(String.self, forKey: .challengeStatusCode) ?? ""
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encodeIfPresent(id, forKey: .id)
    try container.encodeIfPresent(challengeStatusCode, forKey: .challengeStatusCode)
  }
}

