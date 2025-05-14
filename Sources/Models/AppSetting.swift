//
//  AppSetting.swift
//  Models
//
//  Created by suni on 4/25/25.
//

import Foundation
import SharedTypes

public struct AppSetting: Equatable {
  var language: AppLanguage = .eng
  
  public init(language: AppLanguage) {
    self.language = language
  }
}
