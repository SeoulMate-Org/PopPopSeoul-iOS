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
  
  public static func moveAppStore() {
      if let appStoreURL = URL(string: "https://apps.apple.com/app/\(Constants.appStoreId)") {
          DispatchQueue.main.async {
              UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
          }
      }
  }
  
  public static func openInSafari(urlString: String) {
    guard let url = URL(string: urlString) else { return }
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
  
  public static func openInNaveMap(lat: Double, lng: Double, name: String) {
    let urlString = "nmap://place?lat=\(lat)&lng=\(lng)&name=\(name)&appname=\(Bundle.main.bundleIdentifier ?? "")"
    openInSafari(urlString: urlString)
  }
}
