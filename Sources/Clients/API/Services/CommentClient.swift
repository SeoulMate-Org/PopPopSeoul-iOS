//
//  CommentClient.swift
//  Clients
//
//  Created by suni on 4/27/25.
//

import ComposableArchitecture
import Models
import SharedTypes

public struct CommentClient {
  public var get: @Sendable (Int) async throws -> [Comment]
  public var post: @Sendable (Int, String) async throws -> Comment
  public var put: @Sendable (Int, String) async throws -> Comment
  public var delete: @Sendable (Int) async throws -> DefaultProgressResponse
}

extension CommentClient: DependencyKey {
  public static var liveValue: CommentClient {
    @Dependency(\.apiClient) var apiClient
    
    return Self(
      get: { id in
        let query = GetDefaultRequest()
        var pathComponents = Endpoint.comment.pathComponents
        pathComponents.append("\(id)")
        let endpoint = Endpoint(baseUrl: Endpoint.comment.baseUrl, pathComponents: pathComponents)
        let request: Request = .get(endpoint, query: query.queryItems)
        let (data, _) = try await apiClient.send(request)
        
        return try data.decoded()
      },
      post: { id, comment in
        let body = PostCommentRequest(comment: comment, challengeId: id)
        let request: Request = .post(.comment, body: try? body.encoded())
        let (data, _) = try await apiClient.send(request)
        
        return try data.decoded()
      },
      put: { id, comment in
        let body = PutCommentRequest(comment: comment, commentId: id)
        let request: Request = .put(.comment, body: try? body.encoded())
        let (data, _) = try await apiClient.send(request)
        
        return try data.decoded()
      },
      delete: { id in
        var pathComponents = Endpoint.comment.pathComponents
        pathComponents.append("\(id)")
        let endpoint = Endpoint(baseUrl: Endpoint.comment.baseUrl, pathComponents: pathComponents)
        let request: Request = .delete(endpoint)
        let (data, _) = try await apiClient.send(request)
        
        return try data.decoded()
      }
    )
  }
}

public extension DependencyValues {
  var commentClient: CommentClient {
    get { self[CommentClient.self] }
    set { self[CommentClient.self] = newValue }
  }
}
