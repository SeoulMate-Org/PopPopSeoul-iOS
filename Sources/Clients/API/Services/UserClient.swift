//
//  UserClient.swift
//  Clients
//
//  Created by suni on 5/2/25.
//

import Foundation
import ComposableArchitecture
import Models
import SharedTypes

public struct UserClient {
  public var fetch: @Sendable () async throws -> User
  public var putNickname: @Sendable (String) async throws -> Bool
  public var withdraw: @Sendable (Int) async throws -> Bool
}

extension UserClient: DependencyKey {
  public static var liveValue: UserClient {
    @Dependency(\.apiClient) var apiClient
    
    return Self(
      fetch: {
        let request: Request = .get(.userInfo, query: [])
        let (data, _) = try await apiClient.send(request)
        
        return try data.decoded()
      },
      putNickname: { nickname in
        do {
          let request: Request = .put(.userNickname, query: [URLQueryItem(name: "nickname", value: nickname)])
          let (data, _) = try await apiClient.send(request)
          let _: User = try data.decoded()
          return true
        } catch {
          if let apiError = error as? APIErrorResponse, apiError.errorCode == .nickDuplicate {
            return false
          } else {
            throw error
          }
        }
      },
      withdraw: { id in
        let request: Request = .delete(.user, query: [URLQueryItem(name: "userId", value: "\(id)")])
        let (data, _) = try await apiClient.send(request)
        let result: DefaultProcessResponse = try data.decoded()
        return result.isProcessed
      }
    )
  }
}

public extension DependencyValues {
  var userClient: UserClient {
    get { self[UserClient.self] }
    set { self[UserClient.self] = newValue }
  }
}
