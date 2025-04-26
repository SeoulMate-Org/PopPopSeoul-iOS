//
//  DetailChallenge.swift
//  Common
//
//  Created by suni on 4/26/25.
//

import Foundation
import SharedTypes

public struct DetailChallenge: Hashable, Equatable {
  public let id: Int
  public let name: String
  public let title: String
  public let description: String
  public let imageUrl: String
  public let likedCount: Int
  public let progressCount: Int
  public let attractionCount: Int
  public let commentCount: Int
  public let isLiked: Bool
  public let challengeStatusCode: String
  public var challengeStatus: ChallengeStatus? {
    ChallengeStatus.from(apiCode: challengeStatusCode)
  }
  public let attractions: [Attraction]
  public let mainLocation: String
  public let challengeThemeId: Int
  public let challengeThemeName: String
  public let comments: [Comment]

  public init(
    id: Int,
    name: String,
    title: String,
    description: String,
    imageUrl: String,
    likedCount: Int,
    progressCount: Int,
    attractionCount: Int,
    commentCount: Int,
    isLiked: Bool,
    challengeStatusCode: String,
    attractions: [Attraction],
    mainLocation: String,
    challengeThemeId: Int,
    challengeThemeName: String,
    comments: [Comment]
  ) {
    self.id = id
    self.name = name
    self.title = title
    self.description = description
    self.imageUrl = imageUrl
    self.likedCount = likedCount
    self.progressCount = progressCount
    self.attractionCount = attractionCount
    self.commentCount = commentCount
    self.isLiked = isLiked
    self.challengeStatusCode = challengeStatusCode
    self.attractions = attractions
    self.mainLocation = mainLocation
    self.challengeThemeId = challengeThemeId
    self.challengeThemeName = challengeThemeName
    self.comments = comments
  }
}

extension DetailChallenge: Codable {
  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case title
    case description
    case imageUrl
    case likedCount
    case progressCount
    case attractionCount
    case commentCount
    case isLiked
    case challengeStatusCode
    case attractions
    case mainLocation
    case challengeThemeId
    case challengeThemeName
    case comments
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
    description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
    likedCount = try container.decodeIfPresent(Int.self, forKey: .likedCount) ?? 0
    progressCount = try container.decodeIfPresent(Int.self, forKey: .progressCount) ?? 0
    attractionCount = try container.decodeIfPresent(Int.self, forKey: .attractionCount) ?? 0
    commentCount = try container.decodeIfPresent(Int.self, forKey: .commentCount) ?? 0
    isLiked = try container.decodeIfPresent(Bool.self, forKey: .isLiked) ?? false
    challengeStatusCode = try container.decodeIfPresent(String.self, forKey: .challengeStatusCode) ?? ""
    attractions = try container.decodeIfPresent([Attraction].self, forKey: .attractions) ?? []
    mainLocation = try container.decodeIfPresent(String.self, forKey: .mainLocation) ?? ""
    challengeThemeId = try container.decodeIfPresent(Int.self, forKey: .challengeThemeId) ?? -1
    challengeThemeName = try container.decodeIfPresent(String.self, forKey: .challengeThemeName) ?? ""
    comments = try container.decodeIfPresent([Comment].self, forKey: .comments) ?? []
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encodeIfPresent(name, forKey: .name)
    try container.encodeIfPresent(title, forKey: .title)
    try container.encodeIfPresent(description, forKey: .description)
    try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
    try container.encodeIfPresent(likedCount, forKey: .likedCount)
    try container.encodeIfPresent(progressCount, forKey: .progressCount)
    try container.encodeIfPresent(attractionCount, forKey: .attractionCount)
    try container.encodeIfPresent(commentCount, forKey: .commentCount)
    try container.encodeIfPresent(isLiked, forKey: .isLiked)
    try container.encodeIfPresent(challengeStatusCode, forKey: .challengeStatusCode)
    try container.encodeIfPresent(attractions, forKey: .attractions)
    try container.encodeIfPresent(mainLocation, forKey: .mainLocation)
    try container.encodeIfPresent(challengeThemeId, forKey: .challengeThemeId)
    try container.encodeIfPresent(challengeThemeName, forKey: .challengeThemeName)
    try container.encodeIfPresent(comments, forKey: .comments)
  }
}
