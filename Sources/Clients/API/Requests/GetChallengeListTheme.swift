//
//  GetChallengeListTheme.swift
//  Clients
//
//  Created by suni on 4/28/25.
//

import Foundation

public struct GetChallengeListTheme {
  public let themeId: Int
  public let language: String = AppSettingManager.shared.language.apiCode

  public init(themeId: Int) {
    self.themeId = themeId
  }

  public var queryItems: [URLQueryItem] {
    return [
      URLQueryItem(name: "language", value: language),
      URLQueryItem(name: "themeId", value: "\(themeId)")
    ]
  }
}
