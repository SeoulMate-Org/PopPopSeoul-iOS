//
//  GetDefaultPageRequest.swift
//  Clients
//
//  Created by suni on 4/27/25.
//

import Foundation
import Common

public struct GetDefaultPageRequest {
  public let language: String = AppSettingManager.shared.language.apiCode

  public let page: Int = 0
  public let size: Int = 100 // TODO: - 페이징
  
  public var queryItems: [URLQueryItem] {
    return [
      URLQueryItem(name: "page", value: "\(page)"),
      URLQueryItem(name: "size", value: "\(page)"),
      URLQueryItem(name: "language", value: "\(page)")
    ]
  }
}
