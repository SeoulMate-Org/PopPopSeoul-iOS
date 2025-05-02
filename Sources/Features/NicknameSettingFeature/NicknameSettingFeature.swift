//
//  NicknameSettingFeature.swift
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
public struct NicknameSettingFeature {
  
  @Dependency(\.userClient) var userClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    var nickname: String
    
    public init(nickname: String) {
      self.nickname = nickname
      self.inputText = nickname
    }
    
    var inputText: String = ""
    var enabledSave: Bool = false
    var textfieldStatus: TextFieldStatus = .none
  }
  
  public enum TextFieldStatus: Equatable {
    case none
    case good
    case error
    case duplication
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onAppear
    case networkError
    case tappedBack
    case tappedSave
    
    case inputTextChanged(String)
    case duplicate
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
        
      case .tappedSave:
        return .run { [state = state] send in
          do {
            let success = try await userClient.putNickname(state.inputText)
            if success {
              await self.dismiss()
            } else {
              await send(.duplicate)
            }
          } catch {
            await send(.networkError)
          }
        }
        
      case let .inputTextChanged(text):
        state.inputText = text
        
        if text.count > 15 || text.count < 2 {
          state.textfieldStatus = .error
          state.enabledSave = false
        } else {
          state.textfieldStatus = .good
          state.enabledSave = true
        }
        return .none
        
      case .duplicate:
        state.textfieldStatus = .duplication
        return .none
      }
    }
  }
}

// MARK: - Helper
