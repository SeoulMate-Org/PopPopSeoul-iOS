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
  static let authRefresh = Self(baseUrl: apiBaseUrl, pathComponents: ["auth", "refresh"])
}

var apiBaseUrl: String {
  guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
        let dict = NSDictionary(contentsOfFile: path),
        let value = dict["BASE_URL"] as? String else {
    fatalError("❌ secrets.plist의 BASE_URL을 읽을 수 없습니다.")
  }
  return value
}
