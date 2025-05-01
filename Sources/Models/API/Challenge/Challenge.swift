//
//  Challenge.swift
//  Models
//
//  Created by suni on 4/29/25.
//

import Foundation
import SharedTypes

public struct Challenge: Hashable, Equatable, Identifiable {
  public let id: Int
  public let name: String
  public let title: String
  public let description: String
  public let imageUrl: String
  public let mainLocation: String
  public let challengeThemeId: Int
  public let challengeThemeName: String

  public var likes: Int
  public var likedCount: Int
  public var isLiked: Bool

  public var progressCount: Int
  public var commentCount: Int
  public let attractionCount: Int
  public var myStampCount: Int
  public var myStampCountLocal: Int {
    return attractions.count(where:  { $0.isStamped })
  }

  public let distance: Int
  public let displayRank: String

  public var challengeStatusCode: String
  public var challengeStatus: ChallengeStatus? {
    ChallengeStatus.from(apiCode: challengeStatusCode)
  }

  public var comments: [Comment]
  public var attractions: [Attraction]

  public var stampCount: Int {
    attractions.filter { $0.isStamped }.count
  }

  public init(
    id: Int,
    name: String,
    title: String,
    description: String,
    imageUrl: String,
    mainLocation: String,
    challengeThemeId: Int,
    challengeThemeName: String,
    likes: Int,
    likedCount: Int,
    isLiked: Bool,
    progressCount: Int,
    commentCount: Int,
    attractionCount: Int,
    myStampCount: Int,
    distance: Int,
    displayRank: String,
    challengeStatusCode: String,
    comments: [Comment],
    attractions: [Attraction]
  ) {
    self.id = id
    self.name = name
    self.title = title
    self.description = description
    self.imageUrl = imageUrl
    self.mainLocation = mainLocation
    self.challengeThemeId = challengeThemeId
    self.challengeThemeName = challengeThemeName
    self.likes = likes
    self.likedCount = likedCount
    self.isLiked = isLiked
    self.progressCount = progressCount
    self.commentCount = commentCount
    self.attractionCount = attractionCount
    self.myStampCount = myStampCount
    self.distance = distance
    self.displayRank = displayRank
    self.challengeStatusCode = challengeStatusCode
    self.comments = comments
    self.attractions = attractions
  }
}

extension Challenge: Codable {
  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case title
    case description
    case imageUrl
    case mainLocation
    case challengeThemeId
    case challengeThemeName
    case likes
    case likedCount
    case isLiked
    case progressCount
    case commentCount
    case attractionCount
    case myStampCount
    case distance
    case displayRank
    case challengeStatusCode
    case comments
    case attractions
  }
  
  public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)

      id = try container.decode(Int.self, forKey: .id)
      name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
      title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
      description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
      imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
      mainLocation = try container.decodeIfPresent(String.self, forKey: .mainLocation) ?? ""
      challengeThemeId = try container.decodeIfPresent(Int.self, forKey: .challengeThemeId) ?? -1
      challengeThemeName = try container.decodeIfPresent(String.self, forKey: .challengeThemeName) ?? ""

      likes = try container.decodeIfPresent(Int.self, forKey: .likes) ?? 0
      likedCount = try container.decodeIfPresent(Int.self, forKey: .likedCount) ?? 0
      isLiked = try container.decodeIfPresent(Bool.self, forKey: .isLiked) ?? false

      progressCount = try container.decodeIfPresent(Int.self, forKey: .progressCount) ?? 0
      commentCount = try container.decodeIfPresent(Int.self, forKey: .commentCount) ?? 0
      attractionCount = try container.decodeIfPresent(Int.self, forKey: .attractionCount) ?? 0
      myStampCount = try container.decodeIfPresent(Int.self, forKey: .myStampCount) ?? 0

      distance = try container.decodeIfPresent(Int.self, forKey: .distance) ?? 0
      displayRank = try container.decodeIfPresent(String.self, forKey: .displayRank) ?? ""

      challengeStatusCode = try container.decodeIfPresent(String.self, forKey: .challengeStatusCode) ?? ""
      comments = try container.decodeIfPresent([Comment].self, forKey: .comments) ?? []
      attractions = try container.decodeIfPresent([Attraction].self, forKey: .attractions) ?? []
  }
  
  public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      
      try container.encode(id, forKey: .id)
      try container.encodeIfPresent(name, forKey: .name)
      try container.encodeIfPresent(title, forKey: .title)
      try container.encodeIfPresent(description, forKey: .description)
      try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
      try container.encodeIfPresent(mainLocation, forKey: .mainLocation)
      try container.encodeIfPresent(challengeThemeId, forKey: .challengeThemeId)
      try container.encodeIfPresent(challengeThemeName, forKey: .challengeThemeName)

      try container.encodeIfPresent(likes, forKey: .likes)
      try container.encodeIfPresent(likedCount, forKey: .likedCount)
      try container.encodeIfPresent(isLiked, forKey: .isLiked)
      
      try container.encodeIfPresent(progressCount, forKey: .progressCount)
      try container.encodeIfPresent(commentCount, forKey: .commentCount)
      try container.encodeIfPresent(attractionCount, forKey: .attractionCount)
      try container.encodeIfPresent(myStampCount, forKey: .myStampCount)
      
      try container.encodeIfPresent(distance, forKey: .distance)
      try container.encodeIfPresent(displayRank, forKey: .displayRank)
      
      try container.encodeIfPresent(challengeStatusCode, forKey: .challengeStatusCode)
      try container.encodeIfPresent(attractions, forKey: .attractions)
      try container.encodeIfPresent(comments, forKey: .comments)
  }

}
