//
//  GetChallengeListStampRequest.swift
//  Clients
//
//  Created by suni on 4/29/25.
//

import Foundation
import Common

public struct GetChallengeListStampRequest {
  public let language: String = AppSettingManager.shared.language.apiCode
  public let attractionId: Int
  
  public init(attractionId: Int) {
    self.attractionId = attractionId
  }

  public var queryItems: [URLQueryItem] {
    return [
      URLQueryItem(name: "attractionId", value: "\(attractionId)"),
      URLQueryItem(name: "language", value: language)
    ]
  }
}
