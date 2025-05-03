//
//  AppLanguage++.swift
//  Common
//
//  Created by suni on 5/3/25.
//

import Foundation
import SharedTypes

public extension AppLanguage {
  var title: String {
    switch self {
    case .kor: return L10n.korean
    case .eng: return L10n.english
    }
  }
}
