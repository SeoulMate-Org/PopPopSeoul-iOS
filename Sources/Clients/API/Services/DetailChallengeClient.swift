//
//  DetailChallengeClient.swift
//  Clients
//
//  Created by suni on 4/26/25.
//

import ComposableArchitecture
import Models
import SharedTypes

public struct DetailChallengeClient {
  public var get: @Sendable (Int) async throws -> DetailChallenge
}

extension DetailChallengeClient: DependencyKey {
  public static var liveValue: DetailChallengeClient {
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
      }
    )
  }
}

public extension DependencyValues {
  var detailChallengeClient: DetailChallengeClient {
    get { self[DetailChallengeClient.self] }
    set { self[DetailChallengeClient.self] = newValue }
  }
}
