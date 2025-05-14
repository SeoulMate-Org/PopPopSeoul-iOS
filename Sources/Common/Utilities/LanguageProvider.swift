//
//  LanguageProvider.swift
//  Common
//
//  Created by suni on 5/3/25.
//

import Foundation

public protocol LanguageProvider {
  var currentLanguage: String { get }
}

public enum LocalizationManager {
  public static var provider: LanguageProvider?
}
