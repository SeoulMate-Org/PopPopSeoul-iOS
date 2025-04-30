//
//  DetailChallengeFeature.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import Foundation
import ComposableArchitecture
import Common
import SharedTypes
import Models
import Clients

@Reducer
public struct DetailChallengeFeature {
  
  @Dependency(\.challengeClient) var challengeClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    let challengeId: Int
    var challenge: Challenge?
    var showMenu: Bool = false
    
    public init(with id: Int) {
      self.challengeId = id
    }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onApear
    case update(Challenge)
    case getError
    case showLoginAlert
    
    // header
    case tappedBack
    case tappedMore
    case dismissMenu
    case quitChallenge
    
    // attraction
    case tappedAttraction(id: Int)
    
    // comment
    case tappedAllComments(id: Int)
    case tappedEditComment(id: Int, Comment)
    case tappedDeleteComment(id: Int)
    
    // bottom
    case bottomAction(BottomAction)
  }
  
  public enum BottomAction: Equatable {
    case like
    case map
    case stamp
    case start
    case login
  }
  
  // MARK: Reducer
  @Dependency(\.dismiss) var dismiss
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onApear:
        return .run { [state = state] send in
          do {
            let id = state.challengeId
            let challenge = try await challengeClient.get(id)
            await send(.update(challenge))
          } catch {
            await send(.getError)
          }
        }
        
      case .tappedBack:
        return .run { _ in
          await self.dismiss()
        }
        
      case .tappedMore:
        state.showMenu = true
        return .none
        
      case .dismissMenu:
        state.showMenu = false
        return .none
        
      case .quitChallenge:
        // TODO: 챌린지 그만두기 API 호출
        state.showMenu = false
        return .none
        
      case let .update(challenge):
        state.challenge = challenge
        return .none
        
      case .getError:
        // TODO: ERROR 처리
        return .none
        
      case let .bottomAction(action):
        switch action {
        case .like:
          if TokenManager.shared.isLogin {
            return .run { [state = state] send in
              guard let challenge = state.challenge else { return }
              
              // 1. 좋아요 UI 즉시 업데이트
              var update = challenge
              update.isLiked.toggle()
              update.likedCount += update.isLiked ? 1 : -1
              await send(.update(update))
              
              do {
                let response = try await challengeClient.putLike(update.id)
                
                // 필요시 서버 데이터랑 다르면 다시 fetch
                if response.isLiked != update.isLiked {
                  let fresh = try await challengeClient.get(response.id)
                  await send(.update(fresh))
                }
              } catch {
                await send(.getError)
              }
            }
          } else {
            return .send(.showLoginAlert)
          }
          
        case .map:
          return .none
        case .stamp:
          return .none
        case .start:
          return .none
        case .login:
          return .send(.showLoginAlert)
        }
        
      default: return .none
      }
    }
  }
}

// MARK: - Helper
