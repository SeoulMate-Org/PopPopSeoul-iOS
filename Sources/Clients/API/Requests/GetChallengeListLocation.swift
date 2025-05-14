//
//  GetChallengeListLocation.swift
//  Clients
//
//  Created by suni on 4/27/25.
//

import Foundation

public struct GetChallengeListLocation {
  public let locationX: Double
  public let locationY: Double
  public let radius: Int
  public let limit: Int
  public let language: String = AppSettingManager.shared.language.apiCode

  public init(locationX: Double, locationY: Double, radius: Int, limit: Int) {
    self.locationX = locationX
    self.locationY = locationY
    self.radius = radius
    self.limit = limit
  }

  public var queryItems: [URLQueryItem] {
    return [
      URLQueryItem(name: "language", value: language),
      URLQueryItem(name: "locationX", value: "\(locationX)"),
      URLQueryItem(name: "locationY", value: "\(locationY)"),
      URLQueryItem(name: "radius", value: "\(radius)"),
      URLQueryItem(name: "limit", value: "\(limit)")
    ]
  }
}
