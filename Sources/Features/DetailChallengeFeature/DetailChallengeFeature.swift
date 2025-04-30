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
  
  @Dependency(\.attractionClient) var attractionClient
  @Dependency(\.challengeClient) var challengeClient
  @Dependency(\.locationClient) var locationClient
  
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
    case moveToMap(Challenge)
    
    // header
    case tappedBack
    case tappedMore
    case dismissMenu
    case quitChallenge
    
    // attraction
    case tappedAttraction(id: Int)
    case tappedAttractionLike(id: Int)
    case updateAttraction(Attraction)
    case requestLocation
    case locationResult(LocationResult)
    
    // comment
    case tappedAllComments(id: Int, isFocus: Bool)
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
        
      case let .update(new):
        if let challenge = state.challenge,
           challenge.attractions.count == new.attractions.count {
          var newChallenge = new
          copyDistances(from: challenge, to: &newChallenge)
          state.challenge = newChallenge
          return .none
        } else {
          state.challenge = new
          return .send(.requestLocation)
        }
        
      case .getError:
        // TODO: ERROR 처리
        return .none
        
        // Attraction
      case let .tappedAttractionLike(id):
        if TokenManager.shared.isLogin {
          return .run { [state = state] send in
            guard let attraction = state.challenge?.attractions.first(where: { $0.id == id }) else { return }
            
            // 1. 좋아요 UI 즉시 업데이트
            var update = attraction
            update.isLiked.toggle()
            update.likes = max(0, update.likes + (update.isLiked ? 1 : -1))
            await send(.updateAttraction(update))
            
            do {
              let response = try await attractionClient.putLike(update.id)
              
              // 필요시 서버 데이터랑 다르면 다시 fetch
              if response.isLiked != update.isLiked {
                let fresh = try await attractionClient.get(response.id)
                await send(.updateAttraction(fresh))
              }
            } catch {
              await send(.getError)
            }
          }
        } else {
          return .send(.showLoginAlert)
        }
        
      case let .updateAttraction(new):
        guard let index = state.challenge?.attractions.firstIndex(where: { $0.id == new.id }) else { return .none }
        
        state.challenge?.attractions[index] = new
        return .none
                
      case .requestLocation:
        return .run { send in
          let result = await locationClient.getCurrentLocation()
          await send(.locationResult(result))
        }
        
      case let .locationResult(.success(coordinate)):
        guard var challenge = state.challenge else { return .none }

        for (index, attraction) in challenge.attractions.enumerated() {
          if let from = attraction.coordinate {
            challenge.attractions[index].distance = from.distanceFormatted(from: coordinate)
          }
        }

        state.challenge = challenge
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
          if let challenge = state.challenge {
            return .send(.moveToMap(challenge))
          } else {
            return .none
          }
          
        case .stamp:
          return .none
          
        case .start:
          return .run { [state = state] send in
            guard let challenge = state.challenge else { return }
            
            // 1. 좋아요 UI 즉시 업데이트
            var update = challenge
            update.challengeStatusCode = ChallengeStatus.progress.apiCode
            update.progressCount += 1
            await send(.update(update))
            
            do {
              let response = try await challengeClient.putStatus(update.id, .progress)
              
              // 필요시 서버 데이터랑 다르면 다시 fetch
              if response.challengeStatus != update.challengeStatus {
                let fresh = try await challengeClient.get(response.id)
                await send(.update(fresh))
              }
            } catch {
              await send(.getError)
            }
          }
        
        case .login:
          return .send(.showLoginAlert)
        }
        
      default: return .none
      }
    }
  }
}

// MARK: - Helper

extension DetailChallengeFeature {
  func copyDistances(from old: Challenge, to new: inout Challenge) {
    for (index, _) in new.attractions.enumerated() {
      new.attractions[index].distance = old.attractions[index].distance
    }
  }
}
