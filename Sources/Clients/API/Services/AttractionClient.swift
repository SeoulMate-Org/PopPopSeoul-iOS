//
//  AttractionClient.swift
//  Clients
//
//  Created by suni on 4/29/25.
//

import ComposableArchitecture
import Models
import SharedTypes

public struct AttractionClient {
  public var get: @Sendable (Int) async throws -> Attraction
  public var putLike: @Sendable (Int) async throws -> DefaultLikeResponse
}

extension AttractionClient: DependencyKey {
  public static var liveValue: AttractionClient {
    @Dependency(\.apiClient) var apiClient
    
    return Self(
      get: { id in
        let query = GetDefaultRequest()
        var pathComponents = Endpoint.attraction.pathComponents
        pathComponents.append("\(id)")
        let endpoint = Endpoint(baseUrl: Endpoint.attraction.baseUrl, pathComponents: pathComponents)
        let request: Request = .get(endpoint, query: query.queryItems)
        let (data, _) = try await apiClient.send(request)
        
        return try data.decoded()
      },
      putLike: { id in
        let query = DefaultIdRequest(id: id)
        let request: Request = .put(.attractionLike, query: query.queryItems)
        let (data, _) = try await apiClient.send(request)
        
        return try data.decoded()
      }
    )
  }
}

public extension DependencyValues {
  var attractionClient: AttractionClient {
    get { self[AttractionClient.self] }
    set { self[AttractionClient.self] = newValue }
  }
}
