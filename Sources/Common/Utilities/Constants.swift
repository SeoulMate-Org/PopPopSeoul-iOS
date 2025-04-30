//
//  Constants.swift
//  PopPopSeoul
//
//  Created by suni on 4/22/25.
//

import Foundation

public enum Constants {
  public static var appVersion: String {
    Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.1"
  }
  
  public static var appStoreId: String {
    return "6744961871"
  }
  
  public static var naverClientId: String {
    Bundle.main.infoDictionary?["NAVER_CLIENT_ID"] as? String ?? ""
  }
  
  public static var naverClientSecret: String {
    Bundle.main.infoDictionary?["NAVER_CLIENT_SECRET"] as? String ?? ""
  }
}
