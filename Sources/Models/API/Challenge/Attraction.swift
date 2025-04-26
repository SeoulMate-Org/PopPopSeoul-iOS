//
//  AttractionInfo.swift
//  Models
//
//  Created by suni on 4/26/25.
//

import Foundation

public struct Attraction: Hashable, Equatable, Identifiable {
  public let id: Int
  public let name: String
  public let locationX: String
  public let locationY: String
  public let isLiked: Bool
  public let likes: Int
  public let isStamped: Bool
  public let stampCount: Int
  public let imageUrl: String = "http://sohohaneulbit.cafe24.com/files/attach/images/357/358/b6f2a6a51114cd78ae4d64840f0ccb46.jpg"

  public init(
    id: Int,
    name: String,
    locationX: String,
    locationY: String,
    isLiked: Bool,
    likes: Int,
    isStamped: Bool,
    stampCount: Int
  ) {
    self.id = id
    self.name = name
    self.locationX = locationX
    self.locationY = locationY
    self.isLiked = isLiked
    self.likes = likes
    self.isStamped = isStamped
    self.stampCount = stampCount
  }
}

extension Attraction: Codable {
  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case locationX
    case locationY
    case isLiked
    case likes
    case isStamped
    case stampCount
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    locationX = try container.decodeIfPresent(String.self, forKey: .locationX) ?? ""
    locationY = try container.decodeIfPresent(String.self, forKey: .locationY) ?? ""
    isLiked = try container.decodeIfPresent(Bool.self, forKey: .isLiked) ?? false
    likes = try container.decodeIfPresent(Int.self, forKey: .likes) ?? 0
    isStamped = try container.decodeIfPresent(Bool.self, forKey: .isStamped) ?? false
    stampCount = try container.decodeIfPresent(Int.self, forKey: .stampCount) ?? 0
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encodeIfPresent(name, forKey: .name)
    try container.encodeIfPresent(locationX, forKey: .locationX)
    try container.encodeIfPresent(locationY, forKey: .locationY)
    try container.encodeIfPresent(isLiked, forKey: .isLiked)
    try container.encodeIfPresent(likes, forKey: .likes)
    try container.encodeIfPresent(isStamped, forKey: .isStamped)
    try container.encodeIfPresent(stampCount, forKey: .stampCount)
  }
}
