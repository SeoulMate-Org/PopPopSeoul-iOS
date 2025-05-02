//
//  UserDefaultClient.swift
//  Clients
//
//  Created by suni on 4/23/25.
//

import ComposableArchitecture
import Foundation
import SharedTypes

// MARK: - Interface

@DependencyClient
public struct UserDefaultsClient {
  public var boolForKey: @Sendable (UserDefaultsKey) -> Bool = { _ in false }
  public var dataForKey: @Sendable (UserDefaultsKey) -> Data?
  public var doubleForKey: @Sendable (UserDefaultsKey) -> Double = { _ in .leastNonzeroMagnitude }
  public var integerForKey: @Sendable (UserDefaultsKey) -> Int = { _ in -1 }
  public var stringForKey: @Sendable (UserDefaultsKey) -> String? = { _ in nil }
  public var remove: @Sendable (UserDefaultsKey) async -> Void
  public var setBool: @Sendable (Bool, UserDefaultsKey) async -> Void
  public var setData: @Sendable (Data?, UserDefaultsKey) async -> Void
  public var setDouble: @Sendable (Double, UserDefaultsKey) async -> Void
  public var setInteger: @Sendable (Int, UserDefaultsKey) async -> Void
  public var setString: @Sendable (String, UserDefaultsKey) async -> Void
  
  public var hasInitLaunch: Bool {
    boolForKey(.hasInitLaunch)
  }
  
  public func setHasLaunch(_ value: Bool) async {
    await setBool(value, .hasInitLaunch)
  }
  
  public func setLanguage(_ value: AppLanguage) async {
    await setString(value.rawValue, .languageKey)
  }
  
  public var languageKey: String? {
    return stringForKey(.languageKey)
  }
  
  public var isAutoLogin: Bool {
    boolForKey(.isAutoLogin)
  }
  
  public func setIsAutoLogin(_ value: Bool) async {
    await setBool(value, .isAutoLogin)
  }
  
  public var lastStampAttractionId: Int {
    integerForKey(.lastStampAttractionId)
  }
  
  public func setLastStampAttractionId(_ value: Int) async {
    await setInteger(value, .lastStampAttractionId)
  }
  
  public var lastStampAttractionName: String? {
    stringForKey(.lastStampAttractionName)
  }
  
  public func setLastStampAttractionName(_ value: String) async {
    await setString(value, .lastStampAttractionName)
  }
  
  public var isLocationRequestBlocked: Bool {
    boolForKey(.isLocationRequestBlocked)
  }
  
  public func setIsLocationRequestBlocked(_ value: Bool) async {
    await setBool(value, .isLocationRequestBlocked)
  }
  
  public var isLocationNotiEnabled: Bool {
    boolForKey(.isLocationNotiEnabled)
  }
  
  public func setIsLocationNotiEnabled(_ value: Bool) async {
    await setBool(value, .isLocationNotiEnabled)
  }
}

// MARK: - DependencyKey

extension UserDefaultsClient: DependencyKey {
  public static var liveValue: UserDefaultsClient {
    let userDefaults = UncheckedSendable(UserDefaults.standard)
    return Self(
      boolForKey: { userDefaults.value.bool(forKey: $0.rawValue) },
      dataForKey: { userDefaults.value.data(forKey: $0.rawValue) },
      doubleForKey: { userDefaults.value.double(forKey: $0.rawValue) },
      integerForKey: { userDefaults.value.integer(forKey: $0.rawValue) },
      stringForKey: { userDefaults.value.string(forKey: $0.rawValue) },
      remove: { userDefaults.value.removeObject(forKey: $0.rawValue) },
      setBool: { userDefaults.value.set($0, forKey: $1.rawValue) },
      setData: { userDefaults.value.set($0, forKey: $1.rawValue) },
      setDouble: { userDefaults.value.set($0, forKey: $1.rawValue) },
      setInteger: { userDefaults.value.set($0, forKey: $1.rawValue) },
      setString: { userDefaults.value.set($0, forKey: $1.rawValue) }
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

public enum UserDefaultsKey: String {
  case hasInitLaunch
  case languageKey
  case isAutoLogin
  case lastStampAttractionId
  case lastStampAttractionName
  case isLocationRequestBlocked
  case isLocationNotiEnabled
}
