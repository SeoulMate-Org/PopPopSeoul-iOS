//
//  AppLanguage.swift
//  Models
//
//  Created by suni on 4/25/25.
//

import Foundation

public enum AppLanguage: String, Equatable {
  case kor = "ko"
  case eng = "en" 
  
  public var apiCode: String {
    switch self {
    case .kor: return "KOR"
    case .eng: return "ENG"
    }
  }
}

public extension AppLanguage {
  var code: String {
    return self.rawValue
  }
}
