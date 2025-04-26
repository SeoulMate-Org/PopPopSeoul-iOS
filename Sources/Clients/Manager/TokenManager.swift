//
//  TokenManager.swift
//  Models
//
//  Created by suni on 4/25/25.
//

import Foundation
import ComposableArchitecture

public class TokenManager {
  public static let shared = TokenManager()
  
  @Dependency(\.keychainClient) private var keychainClient
  
  // MARK: - In-Memory Cache
  private var _accessToken: String?
  private var _refreshToken: String?
  
  private init() {}
  
  public var isLogin: Bool {
    return _accessToken != nil
  }
  
  // MARK: - Access Token
  public var accessToken: String? {
    if let token = _accessToken {
      return token
    } else {
      let token = keychainClient.accessToken
      _accessToken = token
      return token
    }
  }
  
  public func setAccessToken(_ token: String) async {
    _accessToken = token
    await keychainClient.setAccessToken(token)
  }
  
  public func clearAccessToken() async {
    _accessToken = nil
    await keychainClient.remove(.accessToken)
  }
  
  // MARK: - Refresh Token
  public var refreshToken: String? {
    if let token = _refreshToken {
      return token
    } else {
      let token = keychainClient.refreshToken
      _refreshToken = token
      return token
    }
  }
  
  public func setRefreshToken(_ token: String) async {
    _refreshToken = token
    await keychainClient.setRefreshToken(token)
  }
  
  public func clearRefreshToken() async {
    _refreshToken = nil
    await keychainClient.remove(.refreshToken)
  }
  
  // MARK: - Clear All
  public func clearAll() async {
    await clearAccessToken()
    await clearRefreshToken()
  }
  
}
