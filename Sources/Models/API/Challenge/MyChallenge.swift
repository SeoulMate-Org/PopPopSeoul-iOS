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
  public let imageUrl: String = "http://sohohaneulbit.cafe24.com/files/attach/images/357/358/b6f2a6a51114cd78ae4d64840f0ccb46.jpg"

  public init(
    id: Int,
    name: String,
    title: String,
    likes: Int,
    commentCount: Int,
    attractionCount: Int,
    myStampCount: Int?,
    challengeThemeId: Int,
    challengeThemeName: String
  ) {
    self.id = id
    self.name = name
    self.title = title
    self.likes = likes
    self.commentCount = commentCount
    self.attractionCount = attractionCount
    self.myStampCount = myStampCount ?? 0
    self.challengeThemeId = challengeThemeId
    self.challengeThemeName = challengeThemeName
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
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    try id = container.decode(Int.self, forKey: .id)
    try name = container.decode(String.self, forKey: .name)
    try title = container.decode(String.self, forKey: .title)
    try likes = container.decode(Int.self, forKey: .likes)
    try commentCount = container.decode(Int.self, forKey: .commentCount)
    try attractionCount = container.decode(Int.self, forKey: .attractionCount)
    myStampCount = try container.decodeIfPresent(Int.self, forKey: .myStampCount) ?? 0
    try challengeThemeId = container.decode(Int.self, forKey: .challengeThemeId)
    try challengeThemeName = container.decode(String.self, forKey: .challengeThemeName)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(name, forKey: .name)
    try container.encode(title, forKey: .title)
    try container.encode(likes, forKey: .likes)
    try container.encode(commentCount, forKey: .commentCount)
    try container.encode(attractionCount, forKey: .attractionCount)
    try container.encode(myStampCount, forKey: .myStampCount)
    try container.encode(challengeThemeId, forKey: .challengeThemeId)
    try container.encode(challengeThemeName, forKey: .challengeThemeName)
  }
}
