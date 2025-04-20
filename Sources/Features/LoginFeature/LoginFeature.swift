//
////  LoginFeature.swift
////  PopPopSeoulKit
////
////  Created by suni on 4/21/25.
////
//
//import Foundation
//import ComposableArchitecture
//import Clients
//
//@Reducer
//public struct LoginFeature {
//  init() {}
//  
//  // MARK: State
//
//  @ObservableState
//  struct State: Equatable {  }
//  
//  // MARK: Actions
//  
//  @CasePathable
//  enum Action: Equatable {
//    case tappedGoogle
//    case tappedFacebook
//    case tappedApple
//    case loginResponse(Result<String, LoginError>)
//  }
//  
//  // MARK: Reducer
//  @Dependency(\.loginClient) var loginClient
//  @Dependency(\.authClient) var authClient
//  var body: some Reducer<State, Action> {
//      Reduce { state, action in
//        switch action {
//        case .tappedGoogle:
//          return .run { send in
//            let token = try await loginClient.loginWithGoogle()
//            await send(.loginResponse(.success(token)))
//          } catch: { error in
//            await send(.loginResponse(.failure(.googleError)))
//          }
//
//        case .tappedFacebook:
//          return .run { send in
//            let token = try await loginClient.loginWithFacebook()
//            await send(.loginResponse(.success(token)))
//          } catch: { error in
//            await send(.loginResponse(.failure(.facebookError)))
//          }
//
//        case .tappedApple:
//          return .run { send in
//            let token = try await loginClient.loginWithApple()
//            await send(.loginResponse(.success(token)))
//          } catch: { error in
//            await send(.loginResponse(.failure(.appleError)))
//          }
//
//        case let .loginResponse(.success(token)):
//          return .run { _ in
//            try await authClient.storeToken(token) // 서버에 인증 요청 or 저장
//          }
//
//        case .loginResponse(.failure):
//          return .none
//        }
//      }
//    }
//  
//}
//
//// MARK: - Helper
