//
//  GetChallengeMyRequest.swift
//  PopPopSeoul
//
//  Created by suni on 4/25/25.
//

import Foundation

public struct GetChallengeMyRequest {
  public let myChallenge: String
  public let language: String

  public init(
    myChallenge: String,
    language: String
  ) {
    self.myChallenge = myChallenge
    self.language = language
  }

  public var queryItems: [URLQueryItem] {
    return [
      URLQueryItem(name: "myChallenge", value: myChallenge),
      URLQueryItem(name: "language", value: language)
    ]
  }
}
