
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
import Models
import SharedTypes

@Reducer
public struct LoginFeature {
  init() {}
  
  //  @Dependency(\.authClient) var authClient
  @Dependency(\.authService) var authService
  
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
    case authLogin(String, LoginType)
    case loginResponse(TaskResult<Auth>)
  }
  
  // MARK: Reducer
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .googleSignInCompleted(token):
        print("로그인 성공 \(token)")
        return .send(.authLogin(token, .google))
        
      case let .facebookSignInCompleted(token):
        print("로그인 성공 \(token)")
        return .send(.authLogin(token, .facebook))
        
      case let .appleSignInCompleted(token):
        print("로그인 성공 \(token)")
        return .send(.authLogin(token, .apple))
        
      case .loginError:
        print("❌ 로그인 실패")
        return .none
        
      case let .authLogin(token, loginType):
        let body = AuthLoginBody(token: token, loginType: loginType.rawValue, languageCode: "KOR")
        return .run { send in
          await send(
            .loginResponse(
              TaskResult {
                try await authService.postAuthLogin(body)
              }
            )
          )
        }
        
      case let .loginResponse(.success(result)):
        print("Login Response \(result)")
        return .none
        
      case let .loginResponse(.failure(error)):
        print("❌ APP 로그인 실패 \(error)")
        return .none
      }
    }
  }
  
}

// MARK: - Helper
