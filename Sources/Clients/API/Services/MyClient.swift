//
//  MyClient.swift
//  PopPopSeoul
//
//  Created by suni on 4/25/25.
//

import ComposableArchitecture
import Models
import SharedTypes

public struct MyClient {
  public var fetchChallengeList: @Sendable (String) async throws -> [Challenge]
  public var fetchBadges: @Sendable () async throws -> [MyBadge]
  public var fetchAttractions: @Sendable () async throws -> [Attraction]
}

extension MyClient: DependencyKey {
  public static var liveValue: MyClient {
    @Dependency(\.apiClient) var apiClient
    
    return Self(
      fetchChallengeList: { tab in
        let query = GetChallengeMyRequest(myChallenge: tab)
        let request: Request = .get(.challengeMy, query: query.queryItems)
        let (data, _) = try await apiClient.send(request)
        
        return try data.decoded()
      },
      fetchBadges: {
        let query = GetDefaultRequest()
        let request: Request = .get(.challengeMyBadge, query: query.queryItems)
        let (data, _) = try await apiClient.send(request)
        
        return try data.decoded()
      },
      fetchAttractions: {
        let query = GetDefaultRequest()
        let request: Request = .get(.attractionMy, query: query.queryItems)
        let (data, _) = try await apiClient.send(request)
        
        return try data.decoded()
      }
    )
  }
}

public extension DependencyValues {
  var myClient: MyClient {
    get { self[MyClient.self] }
    set { self[MyClient.self] = newValue }
  }
}
