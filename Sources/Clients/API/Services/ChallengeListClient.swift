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
  public var fetchLocationList: @Sendable (Coordinate) async throws -> [Challenge]
  public var fetchThemeList: @Sendable (ChallengeTheme) async throws -> (ChallengeTheme, [Challenge])
  public var fetchMissingList: @Sendable () async throws -> [Challenge]
  public var fetchSimilarList: @Sendable () async throws -> (attraction: String?, list: [Challenge])
  public var fetchRankList: @Sendable () async throws -> [Challenge]
}

extension ChallengeListClient: DependencyKey {
  public static var liveValue: ChallengeListClient {
    @Dependency(\.apiClient) var apiClient
    @Dependency(\.userDefaultsClient) var userDefaultsClient
    
    return Self(
      fetchLocationList: { coordinate in
        let query = GetChallengeListLocation(
          locationX: coordinate.longitude,
          locationY: coordinate.latitude,
          radius: 5000, limit: 10)
        let request: Request = .get(.challengeListLocation, query: query.queryItems)
        let (data, _) = try await apiClient.send(request)
        
        return try data.decoded()
      },
      fetchThemeList: { theme in
        let query = GetChallengeListTheme(themeId: theme.id)
        let request: Request = .get(.challengeListTheme, query: query.queryItems)
        let (data, _) = try await apiClient.send(request)
        let list: [Challenge] = try data.decoded()
        return (theme, list)
      },
      fetchMissingList: {
        if TokenManager.shared.isLogin {
          let query = GetDefaultRequest()
          let request: Request = .get(.challengeListStamp, query: query.queryItems)
          let (data, _) = try await apiClient.send(request)
          return try data.decoded()
        } else {
          return []
        }
      },
      fetchSimilarList: {
        let lastId = userDefaultsClient.lastStampAttractionId
        if TokenManager.shared.isLogin, lastId > 0,
           let lastName = userDefaultsClient.lastStampAttractionName {
          let query = GetChallengeListStampRequest(attractionId: lastId)
          let request: Request = .get(.challengeListStamp, query: query.queryItems)
          let (data, _) = try await apiClient.send(request)
          let list: [Challenge] = try data.decoded()
          return (lastName, list)
        } else {
          return (nil, [])
        }
      },
      fetchRankList: {
        let query = GetDefaultRequest()
        let request: Request = .get(.challengeListRank, query: query.queryItems)
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
