//
//  MyChallenge.swift
//  PopPopSeoul
//
//  Created by suni on 4/25/25.
//

import Foundation

public struct MyChallenge: Hashable, Equatable {
  public let id: Int
  public let name: String
  public let title: String
  public let likes: Int
  public let commentCount: Int
  public let attractionCount: Int
  public let myStampCount: Int
  public let challengeThemeId: Int
  public let challengeThemeName: String
  public let mainLocation: String
  public let imageUrl: String = "http://sohohaneulbit.cafe24.com/files/attach/images/357/358/b6f2a6a51114cd78ae4d64840f0ccb46.jpg"

  public init(
    id: Int,
    name: String? = nil,
    title: String? = nil,
    likes: Int? = nil,
    commentCount: Int? = nil,
    attractionCount: Int? = nil,
    myStampCount: Int? = nil,
    challengeThemeId: Int? = nil,
    challengeThemeName: String? = nil,
    imageUrl: String? = nil,
    mainLocation: String? = nil
  ) {
    self.id = id
    self.name = name ?? ""
    self.title = title ?? ""
    self.likes = likes ?? 0
    self.commentCount = commentCount ?? 0
    self.attractionCount = attractionCount ?? 0
    self.myStampCount = myStampCount ?? 0
    self.challengeThemeId = challengeThemeId ?? -1
    self.challengeThemeName = challengeThemeName ?? ""
    self.mainLocation = mainLocation ?? ""
//    self.imageUrl = imageUrl ?? ""
  }
}

extension MyChallenge: Codable {

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case title
    case likes
    case commentCount
    case attractionCount
    case myStampCount
    case challengeThemeId
    case challengeThemeName
    case imageUrl
    case mainLocation
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    id = try container.decode(Int.self, forKey: .id)
    name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
    likes = try container.decodeIfPresent(Int.self, forKey: .likes) ?? 0
    commentCount = try container.decodeIfPresent(Int.self, forKey: .commentCount) ?? 0
    attractionCount = try container.decodeIfPresent(Int.self, forKey: .attractionCount) ?? 0
    myStampCount = try container.decodeIfPresent(Int.self, forKey: .myStampCount) ?? 0
    challengeThemeId = try container.decodeIfPresent(Int.self, forKey: .challengeThemeId) ?? -1
    challengeThemeName = try container.decodeIfPresent(String.self, forKey: .challengeThemeName) ?? ""
    mainLocation = try container.decodeIfPresent(String.self, forKey: .mainLocation) ?? ""
//    imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(id, forKey: .id)
    try container.encodeIfPresent(name, forKey: .name)
    try container.encodeIfPresent(title, forKey: .title)
    try container.encodeIfPresent(likes, forKey: .likes)
    try container.encodeIfPresent(commentCount, forKey: .commentCount)
    try container.encodeIfPresent(attractionCount, forKey: .attractionCount)
    try container.encodeIfPresent(myStampCount, forKey: .myStampCount)
    try container.encodeIfPresent(challengeThemeId, forKey: .challengeThemeId)
    try container.encodeIfPresent(challengeThemeName, forKey: .challengeThemeName)
    try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
    try container.encodeIfPresent(mainLocation, forKey: .mainLocation)
  }
}
