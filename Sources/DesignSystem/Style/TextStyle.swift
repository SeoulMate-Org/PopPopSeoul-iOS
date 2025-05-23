//
//  TextStyle.swift
//  Common
//
//  Created by suni on 4/8/25.
//

import UIKit
import SwiftUI

public extension Font {
  static let appTitle1: Font = pretendard(size: 22, weight: .semibold)
  static let appTitle2: Font = pretendard(size: 20, weight: .semibold)
  static let appTitle3: Font = pretendard(size: 18, weight: .semibold)
  static let bodyM: Font = pretendard(size: 16, weight: .medium)
  static let bodyS: Font = pretendard(size: 14, weight: .medium)
  static let captionM: Font = pretendard(size: 12, weight: .medium)
  static let captionL: Font = pretendard(size: 13, weight: .medium)
  static let captionSB: Font = pretendard(size: 13, weight: .semibold)
  static let buttonL: Font = pretendard(size: 18, weight: .semibold)
  static let buttonM: Font = pretendard(size: 16, weight: .semibold)
  static let buttonS: Font = pretendard(size: 12, weight: .semibold)
  
  static func pretendard(size: CGFloat, weight: Font.Weight = .regular) -> Font {
    let name: String
    switch weight {
    case .bold:
      name = "Pretendard-Bold"
    case .semibold:
      name = "Pretendard-SemiBold"
    case .medium:
      name = "Pretendard-Medium"
    default:
      name = "Pretendard-Regular"
    }
    return .custom(name, size: size)
  }
  
  static func smAggro(size: CGFloat, weight: Font.Weight = .regular) -> Font {
    let name: String
    switch weight {
    case .bold:
      name = "OTSBAggroB"
    case .light:
      name = "OTSBAggroL"
    case .medium:
      name = "OTSBAggroM"
    default:
      name = "OTSBAggroM"
    }
    return .custom(name, size: size)
  }
}

public extension UIFont {
  
  static let captionL: UIFont = pretendard(size: 13, weight: .medium)
  
  static func pretendard(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
    let name: String
    switch weight {
    case .bold:
      name = "Pretendard-Bold"
    case .semibold:
      name = "Pretendard-SemiBold"
    case .medium:
      name = "Pretendard-Medium"
    default:
      name = "Pretendard-Regular"
    }
    return UIFont(name: name, size: size)!
  }
}
