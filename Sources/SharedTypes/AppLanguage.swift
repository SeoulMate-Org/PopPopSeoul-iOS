//
//  AppLanguage.swift
//  Models
//
//  Created by suni on 4/25/25.
//

import Foundation

public enum AppLanguage: String, Equatable {
  case kor
  case eng
  
  public var apiCode: String {
    switch self {
    case .kor: return "KOR"
    case .eng: return "ENG"
    }
  }
  
  public var title: String {
    switch self {
    case .kor: return "한국어"
    case .eng: return "English"
    }
  }
}
