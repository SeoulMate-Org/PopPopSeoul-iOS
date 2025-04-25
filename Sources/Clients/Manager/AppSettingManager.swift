//
//  AppSettingManager.swift
//  Models
//
//  Created by suni on 4/25/25.
//

import Foundation
import SharedTypes
import ComposableArchitecture

public class AppSettingManager {
  public static let shared = AppSettingManager()
  
  @Dependency(\.userDefaultsClient) private var userDefaultsClient
  
  // MARK: - In-Memory Cache
  private var _language: AppLanguage?
  
  private init() {}
  
  public var language: AppLanguage {
    get {
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
            return .ko
          } else {
            return .en
          }
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
        _language = .ko
      } else {
        _language = .en
      }
    }
  }
  
  public func setLanguage(_ language: AppLanguage) async {
    _language = language
    await userDefaultsClient.setLanguage(language)
  }
}

