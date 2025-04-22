
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
  
//  @Dependency(\.authClient) var authClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    public init() { }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case googleSignInCompleted(String)
    case facebookSignInCompleted(String)
    case appleSignInCompleted(String)
    case loginError
  }
  
  // MARK: Reducer
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .googleSignInCompleted(token):
        // TODO: - App Login
        print("로그인 성공 \(token)")
        return .none
        
      case let .facebookSignInCompleted(token):
        // TODO: - App Login
        print("로그인 성공 \(token)")
        return .none
        
      case let .appleSignInCompleted(token):
        // TODO: - App Login
        print("로그인 성공 \(token)")
        return .none
        
      case .loginError:
        print("❌ Apple 로그인 실패")
        return .none
        
      }
    }
  }
  
}

// MARK: - Helper
