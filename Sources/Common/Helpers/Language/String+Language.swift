//
//  String+Language.swift
//  Common
//
//  Created by suni on 3/31/25.
//

import Foundation

public extension String {
  var localized: String {
    NSLocalizedString(self, comment: "")
  }

  func localizedFormat(_ args: CVarArg...) -> String {
    String(format: NSLocalizedString(self, comment: ""), arguments: args)
  }

  func localizedFormat(arguments: [CVarArg]) -> String {
      String(format: NSLocalizedString(self, comment: ""), arguments: arguments)
  }
}
