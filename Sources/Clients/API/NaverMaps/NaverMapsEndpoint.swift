//
//  NaverMapsEndpoint.swift
//  Clients
//
//  Created by suni on 4/30/25.
//

import Foundation
import Common

public enum NaverMapsEndpoint: Sendable {
  case staticMap(StaticMapParameters)
  case reverseGeocode(lat: Double, lng: Double)
  case placeSearch(query: String)

  var urlRequest: URLRequest {
    var components: URLComponents
    let headers: [String: String] = [
      "x-ncp-apigw-api-key-id": Constants.naverClientId,
      "x-ncp-apigw-api-key": Constants.naverClientSecret
    ]

    switch self {
    case .staticMap(let params):
      components = URLComponents(string: "\(mapsUrl)/map-static/v2/raster")!
      var queryItems: [URLQueryItem] = [
        .init(name: "w", value: "\(params.width)"),
        .init(name: "h", value: "\(params.height)")
      ]
      
      for marker in params.markers {
        queryItems.append(.init(name: "markers", value: marker.query))
      }
      
      components.queryItems = queryItems

    case let .reverseGeocode(lat, lng):
      components = URLComponents(string: "\(mapsUrl)/map-reversegeocode/v2/gc")!
      components.queryItems = [
        .init(name: "coords", value: "\(lng),\(lat)"),
        .init(name: "output", value: "json"),
        .init(name: "orders", value: "roadaddr,addr")
      ]

    case .placeSearch(let query):
      components = URLComponents(string: "\(mapsUrl)/map-place/v1/search")!
      components.queryItems = [
        .init(name: "query", value: query)
      ]
    }

    var request = URLRequest(url: components.url!)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    return request
  }
}

var mapsUrl: String {
  return "https://maps.apigw.ntruss.com"
}
