//
//  MyChallenge.swift
//  PopPopSeoul
//
//  Created by suni on 4/25/25.
//

import Foundation

public struct MyChallenge: Hashable, Equatable, Identifiable {
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
  public let description: String
  public let isLiked: Bool
  public let distance: Int
  public let displayRank: String

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
    mainLocation: String? = nil,
    description: String? = nil,
    isLiked: Bool? = nil,
    distance: Int? = nil,
    displayRank: String? = nil
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
    self.description = description ?? ""
    self.isLiked = isLiked ?? false
    self.distance = distance ?? 0
    self.displayRank = displayRank ?? ""
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
    case description
    case isLiked
    case distance
    case displayRank
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
    description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    isLiked = try container.decodeIfPresent(Bool.self, forKey: .isLiked) ?? false
    distance = try container.decodeIfPresent(Int.self, forKey: .distance) ?? 0
    displayRank = try container.decodeIfPresent(String.self, forKey: .displayRank) ?? ""
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
    try container.encodeIfPresent(description, forKey: .description)
    try container.encodeIfPresent(isLiked, forKey: .isLiked)
    try container.encodeIfPresent(distance, forKey: .distance)
    try container.encodeIfPresent(displayRank, forKey: .displayRank)
  }
}

// TODD: - Mock 제거
public let mockMyChallenge: MyChallenge = .init(
  id: 1,
  name: "서울 야경 탐방",
  title: "남산타워부터 한강 야경까지",
  likes: 128,
  commentCount: 12,
  attractionCount: 5,
  myStampCount: 2,
  challengeThemeId: 3,
  challengeThemeName: "야경 탐방",
  mainLocation: "서울특별시 중구",
  description: "서울의 아름다운 야경 명소를 탐방하며 스탬프를 모아보세요. 남산타워, 한강공원 등 핫플레이스를 아우르는 챌린지입니다.",
  isLiked: true,
  distance: 3500, // (단위는 미터 정도 가정)
  displayRank: "HIGH"
)
