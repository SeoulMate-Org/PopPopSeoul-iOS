//
//  DefaultProcessResponse.swift
//  Models
//
//  Created by suni on 4/27/25.
//

import Foundation

public struct DefaultProcessResponse: Hashable, Equatable {
  public let id: Int
  public let isProcessed: Bool
  
  public init(id: Int, isProcessed: Bool) {
    self.id = id
    self.isProcessed = isProcessed
  }
}

extension DefaultProcessResponse: Codable {
  private enum CodingKeys: String, CodingKey {
    case id
    case isProcessed
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
    isProcessed = try container.decodeIfPresent(Bool.self, forKey: .isProcessed) ?? false
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encodeIfPresent(id, forKey: .id)
    try container.encodeIfPresent(isProcessed, forKey: .isProcessed)
  }
}
