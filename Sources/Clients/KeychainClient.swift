import ComposableArchitecture
import Foundation
import Security

// MARK: - Interface

@DependencyClient
public struct KeychainClient {
  public var stringForKey: @Sendable (KeychainKey) -> String?
  public var setString: @Sendable (String, KeychainKey) async -> Void
  public var remove: @Sendable (KeychainKey) async -> Void

  public var accessToken: String? {
    stringForKey(.accessToken)
  }

  public func setAccessToken(_ value: String) async {
    await setString(value, .accessToken)
  }

  public var refreshToken: String? {
    stringForKey(.refreshToken)
  }

  public func setRefreshToken(_ value: String) async {
    await setString(value, .refreshToken)
  }
}

// MARK: - DependencyKey

extension KeychainClient: DependencyKey {
  public static var liveValue: KeychainClient {
    return Self(
      stringForKey: { key in
        let query: [String: Any] = [
          kSecClass as String: kSecClassGenericPassword,
          kSecAttrAccount as String: key.rawValue,
          kSecReturnData as String: true
        ]
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)

        if let data = result as? Data,
           let value = String(data: data, encoding: .utf8) {
          return value
        } else {
          return nil
        }
      },
      setString: { value, key in
        let data = value.data(using: .utf8) ?? Data()
        let query: [String: Any] = [
          kSecClass as String: kSecClassGenericPassword,
          kSecAttrAccount as String: key.rawValue
        ]
        SecItemDelete(query as CFDictionary)

        let attributes: [String: Any] = [
          kSecClass as String: kSecClassGenericPassword,
          kSecAttrAccount as String: key.rawValue,
          kSecValueData as String: data
        ]
        SecItemAdd(attributes as CFDictionary, nil)
      },
      remove: { key in
        let query: [String: Any] = [
          kSecClass as String: kSecClassGenericPassword,
          kSecAttrAccount as String: key.rawValue
        ]
        SecItemDelete(query as CFDictionary)
      }
    )
  }
}

// MARK: - DependencyValues

public extension DependencyValues {
  var keychainClient: KeychainClient {
    get { self[KeychainClient.self] }
    set { self[KeychainClient.self] = newValue }
  }
}

// MARK: - Keychain Keys

public enum KeychainKey: String {
  case accessToken
  case refreshToken
}
