//
//  StampChallenges.swift
//  Models
//
//  Created by suni on 5/1/25.
//

import Foundation
import SharedTypes

public struct StampChallenges: Hashable, Equatable {
  public let dataCode: String
  public var challenges: [Challenge]
 
  public init(dataCode: String, challenges: [Challenge]) {
    self.dataCode = dataCode
    self.challenges = challenges
  }
}

extension StampChallenges: Codable {
  private enum CodingKeys: String, CodingKey {
    case dataCode
    case challenges
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    dataCode = try container.decode(String.self, forKey: .dataCode)
    challenges = try container.decodeIfPresent([Challenge].self, forKey: .challenges) ?? []
  }
}
