//
//  AuthClient.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/21/25.
//

import ComposableArchitecture

struct AuthClient {
  var signInWithGoogle: () async throws -> String   // 구글 토큰
  var signInWithFacebook: () async throws -> String // 페이스북 토큰
  var signInWithApple: () async throws -> String    // 애플 토큰
}

extension AuthClient: DependencyKey {
  static let liveValue = AuthClient(
    signInWithGoogle: {
      // ✅ Google SDK 연동 (GIDSignIn.sharedInstance.signIn)
      return "google_access_token"
    },
    signInWithFacebook: {
      // ✅ Facebook SDK 연동 (LoginManager().logIn)
      return "facebook_access_token"
    },
    signInWithApple: {
      // ✅ Apple Sign-In 연동 (ASAuthorizationController)
      return "apple_identity_token"
    }
  )
}

extension DependencyValues {
  var authClient: AuthClient {
    get { self[AuthClient.self] }
    set { self[AuthClient.self] = newValue }
  }
}

