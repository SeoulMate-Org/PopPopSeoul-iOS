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
  public let description: String
  public let address: String
  public let businessHours: String
  public let homepageUrl: String
  public let locationX: String
  public let locationY: String
  public let tel: String
  public let subway: String
  public var isLiked: Bool
  public var likes: Int
  public let isStamped: Bool
  public let stampCount: Int
  public let imageUrl: String
  
  public init(id: Int, name: String, description: String, address: String, businessHours: String, homepageUrl: String, locationX: String, locationY: String, tel: String, subway: String, isLiked: Bool, likes: Int, isStamped: Bool, stampCount: Int, imageUrl: String) {
    self.id = id
    self.name = name
    self.description = description
    self.address = address
    self.businessHours = businessHours
    self.homepageUrl = homepageUrl
    self.locationX = locationX
    self.locationY = locationY
    self.tel = tel
    self.subway = subway
    self.isLiked = isLiked
    self.likes = likes
    self.isStamped = isStamped
    self.stampCount = stampCount
    self.imageUrl = imageUrl
  }
}

extension Attraction: Codable {
  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case description
    case address
    case businessHours
    case homepageUrl
    case locationX
    case locationY
    case tel
    case subway
    case isLiked
    case likes
    case isStamped
    case stampCount
    case imageUrl
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    address = try container.decodeIfPresent(String.self, forKey: .address) ?? ""
    businessHours = try container.decodeIfPresent(String.self, forKey: .businessHours) ?? ""
    homepageUrl = try container.decodeIfPresent(String.self, forKey: .homepageUrl) ?? ""
    locationX = try container.decodeIfPresent(String.self, forKey: .locationX) ?? ""
    locationY = try container.decodeIfPresent(String.self, forKey: .locationY) ?? ""
    tel = try container.decodeIfPresent(String.self, forKey: .tel) ?? ""
    subway = try container.decodeIfPresent(String.self, forKey: .subway) ?? ""
    isLiked = try container.decodeIfPresent(Bool.self, forKey: .isLiked) ?? false
    likes = try container.decodeIfPresent(Int.self, forKey: .likes) ?? 0
    isStamped = try container.decodeIfPresent(Bool.self, forKey: .isStamped) ?? false
    stampCount = try container.decodeIfPresent(Int.self, forKey: .stampCount) ?? 0
    imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encodeIfPresent(name, forKey: .name)
    try container.encodeIfPresent(description, forKey: .description)
    try container.encodeIfPresent(address, forKey: .address)
    try container.encodeIfPresent(businessHours, forKey: .businessHours)
    try container.encodeIfPresent(homepageUrl, forKey: .homepageUrl)
    try container.encodeIfPresent(locationX, forKey: .locationX)
    try container.encodeIfPresent(locationY, forKey: .locationY)
    try container.encodeIfPresent(tel, forKey: .tel)
    try container.encodeIfPresent(subway, forKey: .subway)
    try container.encodeIfPresent(isLiked, forKey: .isLiked)
    try container.encodeIfPresent(likes, forKey: .likes)
    try container.encodeIfPresent(isStamped, forKey: .isStamped)
    try container.encodeIfPresent(stampCount, forKey: .stampCount)
    try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
  }
}
