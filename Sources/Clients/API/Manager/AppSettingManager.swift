//
//  AppSettingManager.swift
//  Models
//
//  Created by suni on 4/25/25.
//

import Foundation
import SharedTypes
import Models
import ComposableArchitecture
import Common

public class AppSettingManager {
  public static let shared = AppSettingManager()
  
  @Dependency(\.userDefaultsClient) private var userDefaultsClient
  @Dependency(\.authClient) private var authClient
  
  // MARK: - In-Memory Cache
  private var _language: AppLanguage?
  public var coordinate: Coordinate?
  
  private init() {}
  
  public var language: AppLanguage {
    if let language = _language {
      return language
    } else {
      if let key = userDefaultsClient.languageKey,
         let language = AppLanguage(rawValue: key) {
        _language = language
        return language
      } else {
        let systemLang = Locale.preferredLanguages.first ?? "en"
        if systemLang.starts(with: "ko") {
          return .kor
        } else {
          return .eng
        }
      }
    }
  }
  
  public func initLanguage() {
    if let key = userDefaultsClient.languageKey,
       let language = AppLanguage(rawValue: key) {
      _language = language
    } else {
      let systemLang = Locale.preferredLanguages.first ?? "en"
      if systemLang.starts(with: "ko") {
        _language = .kor
      } else {
        _language = .eng
      }
    }
    LocalizationManager.provider = self
  }
  
  public func setLanguage(_ language: AppLanguage) async {
    _language = language
    LocalizationManager.provider = self
    await userDefaultsClient.setLanguage(language)
  }
  
  public func hasInitLaunch() async -> Bool {
    if userDefaultsClient.hasInitLaunch {
      return true
    } else {
      await TokenManager.shared.clearAll()
      return false
    }
  }
  
  public func setCoordinate(_ coordinate: Coordinate) {
    self.coordinate = coordinate
  }
}

extension AppSettingManager: LanguageProvider {
  public var currentLanguage: String {
    return language.rawValue
  }
}
