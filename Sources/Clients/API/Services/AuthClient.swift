//
//  AuthClient.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/21/25.
//

import ComposableArchitecture
import Models
import SharedTypes

public struct AuthClient {
  public var autoLogin: @Sendable () async throws -> Bool
  public var login: @Sendable (_ provider: AuthProvider) async throws -> Auth
  public var logout: @Sendable () async throws -> Void
}

extension AuthClient: DependencyKey {
  public static var liveValue: AuthClient {
    @Dependency(\.apiClient) var apiClient
    
    return Self(
      autoLogin: {
        if let refreshToken = TokenManager.shared.refreshToken {
          let body = PostAuthRefreshRequest(refreshToken: refreshToken)
          
          let request: Request = .post(.authRefresh, body: try? body.encoded())
          let (data, _) = try await apiClient.send(request)
                    
          let result: Token = try data.decoded()
          
          await TokenManager.shared.setAccessToken(result.accessToken)
          await TokenManager.shared.setRefreshToken(result.refreshToken)
          
          return true
        } else {
          return false
        }
      },
      login: { provider in
        let body = PostAuthLoginRequest(token: provider.token, loginType: provider.loginType, languageCode: AppSettingManager.shared.language.apiCode)
        
        let request: Request = .post(.authLogin, body: try? body.encoded())
        let (data, _) = try await apiClient.send(request)
        
        let result: Auth = try data.decoded()
        
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

extension AuthProvider {
  var loginType: String {
    switch self {
    case .apple: return "APPLE"
    case .google: return "GOOGLE"
    case .facebook: return "FACEBOOK"
    }
  }
  
  var token: String {
    switch self {
    case let .apple(token): return token
    case let .google(token): return token
    case let .facebook(token): return token
    }
  }
}
