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
  @Dependency(\.challengeClient) var challengeClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    var selectedTheme: ChallengeTheme = .mustSeeSpots
    var themeChallenges: [Challenge] = []
    var shouldScrollToTop: Bool = false
    var showLoginAlert: Bool = false
    
    public init(with theme: ChallengeTheme) {
      self.selectedTheme = theme
    }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onApear
    case showLoginAlert
    case loginAlert(LoginAlertAction)
    case moveToMap(Challenge)
    case networkError
    case setShouldScrollToTop(Bool)
    
    case tappedBack
    case tappedChallenge(Int)
    case tappedLike(Int)
    
    case themeChanged(ChallengeTheme)
    case fetchThemeList(ChallengeTheme)
    case updateThemeList([Challenge])
    case update(Int, Challenge)
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
        
      case let .tappedLike(id):
        if TokenManager.shared.isLogin {
          return .run { [state = state] send in
            guard let index = state.themeChallenges.firstIndex(where: { $0.id == id }) else { return }
            var update = state.themeChallenges[index]
            update.isLiked.toggle()
            update.likes = max(0, update.likes + (update.isLiked ? 1 : -1))
            await send(.update(index, update))
            
            do {
              let response = try await challengeClient.putLike(update.id)
              
              // 필요시 서버 데이터랑 다르면 다시 fetch
              if response.isLiked != update.isLiked {
                let fresh = try await challengeClient.get(response.id)
                await send(.update(index, fresh))
              }
            } catch {
              await send(.networkError)
            }
          }
        } else {
          return .send(.showLoginAlert)
        }
        
      case let .update(index, challenge):
        guard index < state.themeChallenges.count else { return .none }
        state.themeChallenges[index] = challenge
        return .none
        
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
        
      case .showLoginAlert:
        state.showLoginAlert = true
        return .none
        
      case .loginAlert(.cancelTapped):
        state.showLoginAlert = false
        return .none
        
      case .loginAlert(.loginTapped):
        state.showLoginAlert = false
        return .none
        
      case .moveToMap:
        // Main Tab Navigation
        return .none
        
      case .networkError:
        // TODO: - Error 처리
        return .none
        
      case .tappedChallenge:
        // Main Tab Navigation
        return .none
      }
    }
  }
}

// MARK: - Helper
