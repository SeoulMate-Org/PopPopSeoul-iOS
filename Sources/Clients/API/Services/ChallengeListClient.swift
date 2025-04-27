//
//  ChallengeListClient.swift
//  PopPopSeoul
//
//  Created by suni on 4/27/25.
//

import ComposableArchitecture
import Models
import SharedTypes

public struct ChallengeListClient {
  public var fetchLocationList: @Sendable (Coordinate) async throws -> [MyChallenge]
}

extension ChallengeListClient: DependencyKey {
  public static var liveValue: ChallengeListClient {
    @Dependency(\.apiClient) var apiClient
        
    return Self(
      fetchLocationList: { coordinate in
        let query = GetChallengeListLocation(
          locationX: coordinate.longitude,
          locationY: coordinate.latitude,
          radius: 5000, limit: 10)
        let request: Request = .get(.challengeListLocation, query: query.queryItems)
        let (data, _) = try await apiClient.send(request)
        
        return try data.decoded()
      }
    )
  }
}

public extension DependencyValues {
  var callengeListClient: ChallengeListClient {
    get { self[ChallengeListClient.self] }
    set { self[ChallengeListClient.self] = newValue }
  }
}

