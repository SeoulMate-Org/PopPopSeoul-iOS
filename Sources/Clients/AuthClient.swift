//
//  AuthClient.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/21/25.
//

import ComposableArchitecture
import Models

public struct AuthClient {
  public var autoLogin: @Sendable () async throws -> Bool
  public var login: @Sendable (_ provider: AuthProvider) async throws -> Auth
  public var logout: @Sendable () async throws -> Void
}

extension AuthClient: DependencyKey {
  public static var liveValue: AuthClient {
    @Dependency(\.authService) var authService
    
    return Self(
      autoLogin: {
        if let refreshToken = TokenManager.shared.refreshToken {
          let body = PostAuthRefreshRequest(refreshToken: refreshToken)
          
          let result = try await authService.postAuthRefresh(body)
          
          await TokenManager.shared.setAccessToken(result.accessToken)
          await TokenManager.shared.setRefreshToken(result.refreshToken)
          
          return true
        } else {
          return false
        }
      },
      login: { provider in
        let body = PostAuthLoginRequest(token: provider.token, loginType: provider.loginType, languageCode: AppSettingManager.shared.language.languageCode)
        
        let result = try await authService.postAuthLogin(body)
        
        await TokenManager.shared.setAccessToken(result.accessToken)
        await TokenManager.shared.setRefreshToken(result.refreshToken)
        
        return result
      },
      logout: {
        await TokenManager.shared.clearAll()
      }
    )
  }
}

public extension DependencyValues {
  var authClient: AuthClient {
    get { self[AuthClient.self] }
    set { self[AuthClient.self] = newValue }
  }
}

public enum AuthProvider: Equatable {
  case apple(identityToken: String)
  case google(idToken: String)
  case facebook(token: String)
  
  public var loginType: String {
    switch self {
    case .apple: return "APPLE"
    case .google: return "GOOGLE"
    case .facebook: return "FACEBOOK"
    }
  }
  
  public var token: String {
    switch self {
    case let .apple(token): return token
    case let .google(token): return token
    case let .facebook(token): return token
    }
  }
}
