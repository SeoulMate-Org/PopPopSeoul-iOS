//
//  LocationChallenges.swift
//  Models
//
//  Created by suni on 5/1/25.
//

import Foundation
import SharedTypes

public struct LocationChallenges: Hashable, Equatable {
  public let jongGak: Bool
  public var challenges: [Challenge]
 
  public init(jongGak: Bool, challenges: [Challenge]) {
    self.jongGak = jongGak
    self.challenges = challenges
  }
}

extension LocationChallenges: Codable {
  private enum CodingKeys: String, CodingKey {
    case jongGak
    case challenges
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    jongGak = try container.decode(Bool.self, forKey: .jongGak)
    challenges = try container.decodeIfPresent([Challenge].self, forKey: .challenges) ?? []
  }
}
