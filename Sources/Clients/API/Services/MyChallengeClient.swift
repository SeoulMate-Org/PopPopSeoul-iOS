//
//  MyChallengeClient.swift
//  PopPopSeoul
//
//  Created by suni on 4/25/25.
//

import ComposableArchitecture
import Models
import SharedTypes

public struct MyChallengeClient {
  public var fetchList: @Sendable (ChallengeStatus) async throws -> [MyChallenge]
}

extension MyChallengeClient: DependencyKey {
  public static var liveValue: MyChallengeClient {
    @Dependency(\.apiClient) var apiClient
        
    return Self(
      fetchList: { type in
        let query = GetChallengeMyRequest(myChallenge: type.apiCode)
        let request: Request = .get(.challengeMy, query: query.queryItems)
        let (data, _) = try await apiClient.send(request)
        
        return try data.decoded()
      }
    )
  }
}

public extension DependencyValues {
  var myChallengeClient: MyChallengeClient {
    get { self[MyChallengeClient.self] }
    set { self[MyChallengeClient.self] = newValue }
  }
}
