//
//  StaticMapParameters.swift
//  Clients
//
//  Created by suni on 4/30/25.
//

import Foundation

public struct StaticMapParameters: Sendable {
  public var width: Int
  public var height: Int
  public var level: Int
  public var markers: [Marker]

  public init(width: Int = 670, height: Int = 400, level: Int = 16, markers: [Marker] = []) {
    self.width = width
    self.height = height
    self.level = level
    self.markers = markers
  }

  public struct Marker: Sendable {
    public var color: String
    public var position: (lat: String, lng: String)

    public init(color: String = "red", position: (String, String)) {
      self.color = color
      self.position = position
    }

    public var query: String {
      "type:d|size:mid|pos:\(position.lng) \(position.lat)|color:\(color)"
    }
  }
}
