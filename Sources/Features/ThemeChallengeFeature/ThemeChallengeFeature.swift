//
//  ThemeChallengeFeature.swift
//  Features
//
//  Created by suni on 4/29/25.
//

import Foundation
import ComposableArchitecture
import Common
import SharedTypes
import Models
import Clients

@Reducer
public struct ThemeChallengeFeature {
  
  @Dependency(\.callengeListClient) var callengeListClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    var selectedTheme: ChallengeTheme = .mustSeeSpots
    var themeChallenges: [Challenge] = []
    var shouldScrollToTop: Bool = false
    
    public init(with theme: ChallengeTheme) {
      self.selectedTheme = theme
    }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onApear
    case showLoginAlert
    case networkError
    case setShouldScrollToTop(Bool)
    
    case tappedBack
    
    case themeChanged(ChallengeTheme)
    case fetchThemeList(ChallengeTheme)
    case updateThemeList([Challenge])
  }
  // MARK: Reducer
  @Dependency(\.dismiss) var dismiss
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onApear:
        return .run { [state = state] send in
          let theme = state.selectedTheme
          await send(.fetchThemeList(theme))
        }
      case let .setShouldScrollToTop(isTop):
        state.shouldScrollToTop = isTop
        return .none
        
      case .tappedBack:
        return .run { _ in
          await self.dismiss()
        }
        
      case let .themeChanged(theme):
        state.selectedTheme = theme
        return .send(.fetchThemeList(theme))
        
      case let .fetchThemeList(theme):
        return .run { send in
          do {
            let list = try await callengeListClient.fetchThemeList(theme).list
            await send(.updateThemeList(list))
          } catch {
            await send(.networkError)
          }
        }
        
      case let .updateThemeList(list):
        state.themeChallenges = list
        return .send(.setShouldScrollToTop(true))
        
      default: return .none
      }
    }
  }
}

// MARK: - Helper
