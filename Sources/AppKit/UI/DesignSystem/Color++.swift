//
//  UIColor+Extension.swift
//  SeoulMateKit
//
//  Created by suni on 4/2/25.
//

import UIKit

public extension UIColor {
  static func hex(_ hex: UInt, alpha: CGFloat = 1) -> Self {
    Self(
      red: CGFloat((hex & 0xFF0000) >> 16) / 255,
      green: CGFloat((hex & 0x00FF00) >> 8) / 255,
      blue: CGFloat(hex & 0x0000FF) / 255,
      alpha: alpha
    )
  }
}

extension UITraitCollection {
  var isDarkMode: Bool {
    userInterfaceStyle == .dark
  }
}
