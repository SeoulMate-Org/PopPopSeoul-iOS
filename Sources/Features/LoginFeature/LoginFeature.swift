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
import Common

@Reducer
public struct LoginFeature {
  init() {
    
  }
  
  @Dependency(\.authClient) var authClient
  
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
    case authLogin(AuthProvider)
    case successLogin(isInit: Bool)
    case backTapped
    case aroundTapped
  }
  
  // MARK: Reducer
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .googleSignInCompleted(token):
        return .send(.authLogin(.google(idToken: token)))
        
      case let .facebookSignInCompleted(token):
        return .send(.authLogin(.facebook(token: token)))
        
      case let .appleSignInCompleted(token):
        return .send(.authLogin(.apple(identityToken: token)))
        
      case .loginError:
        logger.error("로그인 실패")
        return .none
        
      case let .authLogin(provider):
        return .run { send in
          do {
            let auth = try await authClient.login(provider)
            await send(.successLogin(isInit: auth.isNewUser))
          } catch {
            await send(.loginError)
          }
        }
        
      case .backTapped:
        return .none
        
      case .aroundTapped:
        return .none
        
      case .successLogin:
        return .none
      }
    }
  }
  
}

// MARK: - Helper
