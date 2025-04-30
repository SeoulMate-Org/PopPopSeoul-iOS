//
//  PutChallengeStatusRequest.swift
//  PopPopSeoul
//
//  Created by suni on 5/1/25.
//

import Foundation
import Common

public struct PutChallengeStatusRequest: Encodable {
  public init(
    id: Int,
    status: String
  ) {
    self.id = id
    self.status = status
  }

  public let id: Int
  public let status: String

  public var queryItems: [URLQueryItem] {
    return [
      URLQueryItem(name: "id", value: "\(id)"),
      URLQueryItem(name: "status", value: status)
    ]
  }
}
