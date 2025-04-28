//
//  Request.swift
//  Clients
//
//  Created by suni on 4/23/25.
//

import Foundation
import Common

public struct Request: Sendable {
  let endpoint: Endpoint
  let httpMethod: HTTPMethod
  var headers: [String: String] = defaultHeaders
  var queryItems: [URLQueryItem] = []
  var body: Data?
  var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy

  public init(
    endpoint: Endpoint,
    httpMethod: HTTPMethod,
    headers: [String: String] = defaultHeaders,
    queryItems: [URLQueryItem] = [],
    body: Data? = nil,
    cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
  ) {
    self.endpoint = endpoint
    self.httpMethod = httpMethod
    self.headers = headers
    self.queryItems = queryItems
    self.body = body
    self.cachePolicy = cachePolicy
  }

  public func makeRequest() throws -> URLRequest {
    guard var components = URLComponents(string: endpoint.url) else {
      throw APIRequestBuildError.invalidURL
    }
    // TODO: - 테스트 서버
    components.scheme = "http"
//    components.scheme = "https"
    if !queryItems.isEmpty {
      components.queryItems = queryItems
    }
    guard let url = components.url else {
      throw APIRequestBuildError.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod.rawValue
    request.allHTTPHeaderFields = headers
    request.httpBody = body

    request.cachePolicy = cachePolicy
    
    if let token = TokenManager.shared.accessToken {
      request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    return request
  }
}

public extension Request {
  static func get(_ endpoint: Endpoint, query: [URLQueryItem] = []) -> Request {
    Request(endpoint: endpoint, httpMethod: .get, queryItems: query)
  }

  static func post(_ endpoint: Endpoint, body: Data?) -> Request {
    Request(endpoint: endpoint, httpMethod: .post, body: body)
  }

  static func put(_ endpoint: Endpoint, body: Data?) -> Request {
    Request(endpoint: endpoint, httpMethod: .put, body: body)
  }
  
  static func put(_ endpoint: Endpoint, query: [URLQueryItem] = []) -> Request {
    Request(endpoint: endpoint, httpMethod: .put, queryItems: query)
  }
  
  static func delete(_ endpoint: Endpoint) -> Request {
    Request(endpoint: endpoint, httpMethod: .delete)
  }
}

// MARK: Helper

public let defaultHeaders = [
  "Content-Type": "application/json"
]

enum APIRequestBuildError: Error {
  case invalidURL
}
