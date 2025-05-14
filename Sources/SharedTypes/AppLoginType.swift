//
//  AuthProvider.swift
//  PopPopSeoul
//
//  Created by suni on 4/25/25.
//

import Foundation

public enum AuthProvider: Equatable {
  case apple(identityToken: String)
  case google(idToken: String)
  case facebook(email: String)
}

public enum AppLoginType: String, Equatable {
  case apple = "APPLE"
  case google = "GOOGLE"
  case facebook = "FACEBOOK"
  case none
}
