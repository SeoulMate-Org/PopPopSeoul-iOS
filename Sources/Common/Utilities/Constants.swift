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
}
