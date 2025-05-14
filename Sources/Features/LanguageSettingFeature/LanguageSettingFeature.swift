//
//  LanguageSettingFeature.swift
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
public struct LanguageSettingFeature {
  
  @Dependency(\.userDefaultsClient) var userDefaultsClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    var language: AppLanguage
    
    var showAlert: Bool = false
    
    public init(language: AppLanguage) {
      self.language = language
    }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onAppear
    case tappedLanguage(AppLanguage)
    case networkError
    case tappedBack
    
    case tappedCancel
    case tappedChangeLanguage
    case appReLaunch
  }
  
  // MARK: Reducer
  @Dependency(\.dismiss) var dismiss
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        
      case .onAppear:
        return .none
        
      case let .tappedLanguage(language):
        state.language = language
        state.showAlert = true
        return .none

      case .tappedBack:
        return .run { _ in
          await self.dismiss()
        }
        
      case .networkError:
        // TODO: ERROR 처리
        return .none
        
      case .tappedCancel:
        state.language = state.language == .kor ? .eng : .kor
        state.showAlert = false
        return .none
        
      case .tappedChangeLanguage:
        return .run { [state = state] send in
          await AppSettingManager.shared.setLanguage(state.language)
          await send(.appReLaunch)
        }
        
      case .appReLaunch:
        // Main Tab Navigation
        return .none
      }
    }
  }
}

// MARK: - Helper
