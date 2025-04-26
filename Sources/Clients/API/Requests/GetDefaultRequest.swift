//
//  GetChallenge.swift
//  Clients
//
//  Created by suni on 4/26/25.
//

import Foundation
import Common

public struct GetDefaultRequest {
  public let language: String = AppSettingManager.shared.language.apiCode

  public var queryItems: [URLQueryItem] {
    return [
      URLQueryItem(name: "language", value: language)
    ]
  }
}
