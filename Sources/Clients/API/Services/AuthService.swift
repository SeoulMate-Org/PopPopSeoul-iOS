//
//  AuthService.swift
//  Clients
//
//  Created by suni on 4/23/25.
//

import ComposableArchitecture
import Foundation

// MARK: Interface

@DependencyClient
public struct AuthService {
  public var postAuthLogin: @Sendable (AuthLoginBody) async throws -> Auth
}

// MARK: Live

extension AuthService: DependencyKey {
  public static var liveValue: AuthService {
    @Dependency(\.apiClient) var apiClient

    return Self(
      postAuthLogin: { body in
        let request: Request = .post(.authLogin, body: try? body.encoded())
        let (data, _) = try await apiClient.send(request)
        return try data.decoded()
      }
    )
  }
}

// MARK: Mocks and failing used for previews and tests

extension AuthService: TestDependencyKey {
  public static let testValue: AuthService = Self()
  public static let previewValue: AuthService = Self()
}

public extension DependencyValues {
  var authService: AuthService {
    get { self[AuthService.self] }
    set { self[AuthService.self] = newValue }
  }
}

public struct ApiResponse: Codable, Equatable {
  public init(status: String?) {
    self.status = status
  }

  public var status: String?
}
