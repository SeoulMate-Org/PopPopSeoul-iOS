//
//  WithdrawFeature.swift
//  Features
//
//  Created by suni on 5/3/25.
//

import Foundation
import ComposableArchitecture
import Common
import SharedTypes
import Models
import Clients

@Reducer
public struct WithdrawFeature {
  
  @Dependency(\.userClient) var userClient
  @Dependency(\.authClient) var authClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    var user: User
    
    var showAlert: Bool = false
    
    public init(user: User) {
      self.user = user
    }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onAppear
    case networkError
    case tappedBack
    
    case showAlert
    case dismissAlert
    case tappedWithdraw
  }
  
  // MARK: Reducer
  @Dependency(\.dismiss) var dismiss
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        
      case .onAppear:
        return .none

      case .tappedBack:
        return .run { _ in
          await self.dismiss()
        }
        
      case .networkError:
        // TODO: ERROR 처리
        return .none
        
      case .showAlert:
        state.showAlert = true
        return .none
        
      case .dismissAlert:
        state.showAlert = false
        return .none
        
      case .tappedWithdraw:
        return .run { [state = state] send in
          do {
            let success = try await userClient.withdraw(state.user.id)
            if success {
              try? await authClient.logout()
              await self.dismiss()
            } else {
              await send(.networkError)
            }
          } catch {
            await send(.networkError)
          }
        }
      }
    }
  }
}

// MARK: - Helper
