//
//  UserClient.swift
//  Clients
//
//  Created by suni on 5/2/25.
//

import ComposableArchitecture
import Models
import SharedTypes

public struct UserClient {
  public var fetch: @Sendable () async throws -> User
}

extension UserClient: DependencyKey {
  public static var liveValue: UserClient {
    @Dependency(\.apiClient) var apiClient
    
    return Self(
      fetch: {
        let request: Request = .get(.userInfo, query: [])
        let (data, _) = try await apiClient.send(request)
        
        return try data.decoded()
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
