
//  LoginFeature.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/21/25.
//

import Foundation
import ComposableArchitecture
import Clients
import AuthenticationServices
import FacebookLogin
import GoogleSignIn
import FirebaseCore

@Reducer
public struct LoginFeature {
  init() {}
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    public init() { }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case googleButtonTapped
    case facebookButtonTapped
    case appleSignInCompleted(ASAuthorization) // ✅ 성공한 경우만 다룸
    case appleSignInFailed(String) // ✅ 에러 메시지로 추상화
  }
  
  // MARK: Reducer
  //  @Dependency(\.loginClient) var loginClient
  //  @Dependency(\.authClient) var authClient
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .googleButtonTapped:
        // Google Sign-In 로직은 View에서 직접 처리, 필요시 Effect로 처리 가능
        return .none
        
      case .facebookButtonTapped:
        // Facebook 로그인도 View에서 직접 처리 후 필요한 token을 다시 Action으로 보낼 수 있음
        return .none
        
      case let .appleSignInCompleted(result):
        if let credential = result.credential as? ASAuthorizationAppleIDCredential,
           let tokenData = credential.identityToken,
           let token = String(data: tokenData, encoding: .utf8) {
          print("✅ Apple token: \(token)")
          // 서버 전송 등 추가 작업 가능
        }
        return .none
        
      case let .appleSignInFailed(error):
        print("❌ Apple 로그인 실패: \(error)")
        return .none
        
      }
    }
  }
  
}

// MARK: - Helper
