//
//  AppLocation.swift
//  PopPopSeoul
//
//  Created by suni on 4/27/25.
//

import Foundation

public struct AppLocation: Codable, Hashable {
  public init(coordinate: Coordinate, radius: Int, limit: Int) {
    self.coordinate = coordinate
    self.radius = radius
    self.limit = limit
  }

  public let coordinate: Coordinate
  public let radius: Int
  public let limit: Int
}
