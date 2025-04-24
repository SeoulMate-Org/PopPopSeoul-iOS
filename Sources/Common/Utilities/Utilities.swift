//
//  Utilities.swift
//  Common
//
//  Created by suni on 4/24/25.
//

import Foundation
import UIKit

public class Utility {
  
  public static let screenHeight = UIScreen.main.bounds.height
  public static let screenWidth = UIScreen.main.bounds.width
  public static let window = UIApplication.shared.connectedScenes
    .compactMap { ($0 as? UIWindowScene)?.keyWindow }
    .first
  public static let safeTop = window?.safeAreaInsets.top ?? 0
  public static let safeBottom = window?.safeAreaInsets.bottom ?? 0
  
}
