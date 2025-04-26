//
//  AuthClient.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/21/25.
//

import ComposableArchitecture
import Models
import SharedTypes
import Common

public struct AuthClient {
  public var isRefreshing: @Sendable () async -> Bool
  public var setRefreshing: @Sendable (_ isRefreshing: Bool) async -> Void
  
  public var refresh: @Sendable () async throws -> Void
  public var login: @Sendable (_ provider: AuthProvider) async throws -> Auth
  public var fbLogin: @Sendable (_ provider: AuthProvider) async throws -> Auth
  public var logout: @Sendable () async throws -> Void
}

extension AuthClient: DependencyKey {
  public static var liveValue: AuthClient {
    @Dependency(\.apiClient) var apiClient
    
    let isRefreshingBox = AsyncBox(value: false) // ✨ 내부 상태 관리용
    
    return Self(
      isRefreshing: {
        await isRefreshingBox.value
      },
      setRefreshing: { newValue in
        await isRefreshingBox.set(newValue)
      },
      refresh: {
        do {
          await TokenManager.shared.clearAccessToken()
          await isRefreshingBox.set(true)
          
          guard let refreshToken = TokenManager.shared.refreshToken else {
            throw NetworkRequestError.dontHaveRefreshToken
          }

          let body = PostAuthRefreshRequest(refreshToken: refreshToken)
          
          let request: Request = .post(.authRefresh, body: try? body.encoded())
          let (data, _) = try await apiClient.send(request)
          
          let result: Token = try data.decoded()
          
          await TokenManager.shared.setAccessToken(result.accessToken)
          await TokenManager.shared.setRefreshToken(result.refreshToken)
          await isRefreshingBox.set(false)
        } catch {
          await TokenManager.shared.clearRefreshToken()
          await isRefreshingBox.set(false)
          throw error
        }
      },
      login: { provider in
        let body = PostAuthLoginRequest(token: "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwiZW1haWwiOiJ0ZXN0QGV4YW1wbGUuY29tIiwiaXNzIjoiYWNjb3VudHMuZ29vZ2xlLmNvbSIsImF1ZCI6InlvdXItY2xpZW50LWlkIiwiZXhwIjo5OTk5OTk5OTk5fQ.dummy-signature", loginType: "GOOGLE")
//        let body = PostAuthLoginRequest(token: provider.token, loginType: provider.loginType, languageCode: AppSettingManager.shared.language.apiCode)
        
        let request: Request = .post(.authLogin, body: try? body.encoded())
        let (data, _) = try await apiClient.send(request)
        
        let result: Auth = try data.decoded()
        
        await TokenManager.shared.setAccessToken(result.accessToken)
        await TokenManager.shared.setRefreshToken(result.refreshToken)
        
        return result
      },
      fbLogin: { provider in
        let body = PostAuthLoginFbIosRequest(email: provider.token)
        
        let request: Request = .post(.authLoginFbIos, body: try? body.encoded())
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
    case let .facebook(email): return email
    }
  }
  
  var email: String {
    switch self {
    case let .apple(token): return token
    case let .google(token): return token
    case let .facebook(email): return email
    }
  }
}
