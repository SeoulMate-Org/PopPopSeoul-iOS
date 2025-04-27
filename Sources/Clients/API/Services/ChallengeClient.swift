//
//  ChallengeClient.swift
//  Clients
//
//  Created by suni on 4/26/25.
//

import ComposableArchitecture
import Models
import SharedTypes

public struct ChallengeClient {
  public var get: @Sendable (Int) async throws -> DetailChallenge
  public var putLike: @Sendable (Int) async throws -> DefaultLikeResponse
}

extension ChallengeClient: DependencyKey {
  public static var liveValue: ChallengeClient {
    @Dependency(\.apiClient) var apiClient
    
    return Self(
      get: { id in
        let query = GetDefaultRequest()
        var pathComponents = Endpoint.challenge.pathComponents
        pathComponents.append("\(id)")
        let endpoint = Endpoint(baseUrl: Endpoint.challenge.baseUrl, pathComponents: pathComponents)
        let request: Request = .get(endpoint, query: query.queryItems)
        let (data, _) = try await apiClient.send(request)
        
        return try data.decoded()
      },
      putLike: { id in
        let query = DefaultIdRequest(id: id)
        let request: Request = .put(.challengeLike, query: query.queryItems)
        let (data, _) = try await apiClient.send(request)
        
        return try data.decoded()
      }
    )
  }
}

public extension DependencyValues {
  var challengeClient: ChallengeClient {
    get { self[ChallengeClient.self] }
    set { self[ChallengeClient.self] = newValue }
  }
}
