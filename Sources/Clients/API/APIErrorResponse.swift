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
  
  public var errorCode: APIErrorCode {
    APIErrorCode(rawValue: code) ?? .unknown
  }
}

public enum APIErrorCode: String, Equatable {
  // 댓글
  case commentNotFound = "R0007"
  
  // 유저
  case userNotFound = "U0002"
  case loginRequired = "U0001"
  
  // 챌린지
  case challengeNotFound = "R0002"
  
  // 관광지
  case placeNotFound = "R0001"
  
  // 테마
  case themeNotFound = "R0003"
  
  // 인증
  case expiredAccessToken = "A0010"
  case invalidTokenType = "A0002"
  
  // 알 수 없는 에러
  case unknown
}
