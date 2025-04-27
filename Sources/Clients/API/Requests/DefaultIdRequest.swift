//
//  DefaultIdRequest.swift
//  PopPopSeoul
//
//  Created by suni on 4/27/25.
//

import Foundation
import Common

public struct DefaultIdRequest {
  public let id: Int

  public init(id: Int) {
    self.id = id
  }
  
  public var queryItems: [URLQueryItem] {
    return [
      URLQueryItem(name: "id", value: "\(id)")
    ]
  }
}
