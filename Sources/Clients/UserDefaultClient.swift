//
//  UserDefaultClient.swift
//  Clients
//
//  Created by suni on 4/23/25.
//

import ComposableArchitecture
import Foundation

// MARK: - Interface

@DependencyClient
public struct UserDefaultsClient {
  public var boolForKey: @Sendable (String) -> Bool = { _ in false }
  public var dataForKey: @Sendable (String) -> Data?
  public var doubleForKey: @Sendable (String) -> Double = { _ in .leastNonzeroMagnitude }
  public var integerForKey: @Sendable (String) -> Int = { _ in -1 }
  public var stringForKey: @Sendable (String) -> String? = { _ in nil }
  public var remove: @Sendable (String) async -> Void
  public var setBool: @Sendable (Bool, String) async -> Void
  public var setData: @Sendable (Data?, String) async -> Void
  public var setDouble: @Sendable (Double, String) async -> Void
  public var setInteger: @Sendable (Int, String) async -> Void
  public var setString: @Sendable (String, String) async -> Void
  
  public var hasSeenOnboarding: Bool {
    boolForKey(onboardingKey)
  }
  
  public func setHasSeenOnboarding(_ value: Bool) async {
    await setBool(value, onboardingKey)
  }
  
  public var selectedLanguage: String? {
    stringForKey(languageKey)
  }
  
  public func setSelectedLanguage(_ value: String) async {
    await setString(value, languageKey)
  }
}

// MARK: - DependencyKey

extension UserDefaultsClient: DependencyKey {
  public static var liveValue: UserDefaultsClient {
    let userDefaults = UncheckedSendable(UserDefaults.standard)
    return Self(
      boolForKey: { userDefaults.value.bool(forKey: $0) },
      dataForKey: { userDefaults.value.data(forKey: $0) },
      doubleForKey: { userDefaults.value.double(forKey: $0) },
      integerForKey: { userDefaults.value.integer(forKey: $0) },
      stringForKey: { userDefaults.value.string(forKey: $0) },
      remove: { userDefaults.value.removeObject(forKey: $0) },
      setBool: { userDefaults.value.set($0, forKey: $1) },
      setData: { userDefaults.value.set($0, forKey: $1) },
      setDouble: { userDefaults.value.set($0, forKey: $1) },
      setInteger: { userDefaults.value.set($0, forKey: $1) },
      setString: { userDefaults.value.set($0, forKey: $1) }
    )
  }
}

// MARK: - DependencyValues

public extension DependencyValues {
  var userDefaultsClient: UserDefaultsClient {
    get { self[UserDefaultsClient.self] }
    set { self[UserDefaultsClient.self] = newValue }
  }
}

// MARK: - UserDefaults Keys

private let onboardingKey = "hasSeenOnboarding"
private let languageKey = "selectedLanguage"
