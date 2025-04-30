//
//  DefaultLikeResponse.swift
//  PopPopSeoul
//
//  Created by suni on 4/27/25.
//

import Foundation

public struct DefaultLikeResponse: Hashable, Equatable {
  public let id: Int
  public let isLiked: Bool
  
  public init(id: Int, isLiked: Bool) {
    self.id = id
    self.isLiked = isLiked
  }
}

extension DefaultLikeResponse: Codable {
  private enum CodingKeys: String, CodingKey {
    case id
    case isLiked
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
    isLiked = try container.decodeIfPresent(Bool.self, forKey: .isLiked) ?? false
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encodeIfPresent(id, forKey: .id)
    try container.encodeIfPresent(isLiked, forKey: .isLiked)
  }
}
