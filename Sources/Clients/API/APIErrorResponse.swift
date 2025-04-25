//
//  APIErrorResponse.swift
//  Models
//
//  Created by suni on 4/25/25.
//

import Foundation

public struct APIErrorResponse: Decodable, Error, Equatable {
  public let code: String
  public let message: String
}
