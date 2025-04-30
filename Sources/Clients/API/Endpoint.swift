import Foundation

/// A structure to define an endpoint on the Critical Maps API
public struct Endpoint: Sendable {
  public let baseUrl: String
  public let pathComponents: [String]

  public init(baseUrl: String, pathComponents: [String] = []) {
    self.baseUrl = baseUrl
    self.pathComponents = pathComponents
  }

  var url: String {
    guard !pathComponents.isEmpty else {
      return baseUrl
    }
    let path = pathComponents.joined(separator: "/")
    return "\(baseUrl)/\(path)"
  }
}

public extension Endpoint {
  static let authLogin = Self(baseUrl: apiBaseUrl, pathComponents: ["auth", "login"])
  static let authLoginFbIos = Self(baseUrl: apiBaseUrl, pathComponents: ["auth", "logint", "fb", "ios"])
  static let authRefresh = Self(baseUrl: apiBaseUrl, pathComponents: ["auth", "refresh"])
  static let challengeMy = Self(baseUrl: apiBaseUrl, pathComponents: ["challenge", "my"])
  static let challenge = Self(baseUrl: apiBaseUrl, pathComponents: ["challenge"])
  static let challengeListLocation = Self(baseUrl: apiBaseUrl, pathComponents: ["challenge", "list", "location"])
  static let challengeListTheme = Self(baseUrl: apiBaseUrl, pathComponents: ["challenge", "list", "theme"])
  static let challengeListStamp = Self(baseUrl: apiBaseUrl, pathComponents: ["challenge", "list", "stamp"])
  static let challengeListRank = Self(baseUrl: apiBaseUrl, pathComponents: ["challenge", "list", "rank"])
  static let challengeLike = Self(baseUrl: apiBaseUrl, pathComponents: ["challenge", "like"])
  static let challengeStatus = Self(baseUrl: apiBaseUrl, pathComponents: ["challenge", "status"])
  static let comment = Self(baseUrl: apiBaseUrl, pathComponents: ["comment"])
  static let attraction = Self(baseUrl: apiBaseUrl, pathComponents: ["attraction"])
  static let attractionLike = Self(baseUrl: apiBaseUrl, pathComponents: ["attraction", "like"])
  
  // MARK: - MAPS
  static let mapsStaticRaster = Self(baseUrl: mapsUrl, pathComponents: ["map-static", "v2", "raster"])
}

var apiBaseUrl: String {
  return Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? "https://"
}
