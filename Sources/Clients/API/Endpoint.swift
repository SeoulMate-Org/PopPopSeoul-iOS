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
  static let challengeLike = Self(baseUrl: apiBaseUrl, pathComponents: ["challenge", "like"])
  static let comment = Self(baseUrl: apiBaseUrl, pathComponents: ["comment"])
}

var apiBaseUrl: String {
  guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
        let dict = NSDictionary(contentsOfFile: path),
//        let value = dict["BASE_URL"] as? String else {
        // TODO: - 테스트 서버
        let value = dict["TEST_BASE_URL"] as? String else {
    fatalError("❌ secrets.plist의 BASE_URL을 읽을 수 없습니다.")
  }
  return value
}
