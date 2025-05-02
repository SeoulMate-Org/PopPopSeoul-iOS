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
  public var stamp: @Sendable (Int, String) async throws -> DefaultProcessResponse
}

extension AttractionClient: DependencyKey {
  public static var liveValue: AttractionClient {
    @Dependency(\.apiClient) var apiClient
    @Dependency(\.userDefaultsClient) var userDefaultsClient
    
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
      },
      stamp: { id, name in
        let query = DefaultIdRequest(id: id)
        let request: Request = .post(.attractionStamp, query: query.queryItems)
        let (data, _) = try await apiClient.send(request)
        let result: DefaultProcessResponse = try data.decoded()
        
        if result.isProcessed {
          await userDefaultsClient.setLastStampAttractionId(id)
          await userDefaultsClient.setLastStampAttractionName(name)
        }
        return result
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
