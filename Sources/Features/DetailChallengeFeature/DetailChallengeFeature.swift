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
  @Dependency(\.commentClient) var commentClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    let challengeId: Int
    var challenge: Challenge?
    var showMenu: Bool = false
    var showLoginAlert: Bool = false
    var showToast: Toast?
    
    var deletingComment: Int?
    var updateAttractions: [Attraction]?
    
    public init(with id: Int) {
      self.challengeId = id
    }
  }
  
  public enum Toast: Equatable {
    case deleteComplete
    case notNearAttraction
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onApear
    case update(Challenge)
    case getError
    case networkError
    case showLoginAlert
    case loginAlert(LoginAlertAction)
    case moveToMap(Challenge)
    case showToast(Toast)
    case dismissToast
    case completeStamp([Attraction])
    
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
    case updateUserCoordinate(Coordinate)
    
    // comment
    case tappedAllComments(id: Int, isFocus: Bool)
    case tappedEditComment(id: Int, Comment)
    case tappedDeleteComment(id: Int)
    case cancelDeleteComment
    case deleteComment(Int)
    case moveToAllComment(id: Int, comment: Comment?, isFocus: Bool)
    
    // bottom
    case bottomAction(BottomAction)
    case notNearAttraction
    case locationRequired
    case checkStamp(Coordinate)
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
          return .merge(
            .run { send in
              if let coordinate = AppSettingManager.shared.coordinate {
                await send(.updateUserCoordinate(coordinate))
              }
            },
            .run { send in
              await send(.requestLocation)
            })
        }
        
      case .getError:
        // TODO: ERROR 처리
        return .none
        
      case .networkError:
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
        AppSettingManager.shared.setCoordinate(coordinate)
        return .send(.updateUserCoordinate(coordinate))
        
      case let .updateUserCoordinate(coordinate):
        guard var challenge = state.challenge else { return .none }

        for (index, attraction) in challenge.attractions.enumerated() {
          if let from = attraction.coordinate {
            challenge.attractions[index].distance = from.distance(from: coordinate)
          }
        }

        state.challenge = challenge
        return .none
        
      case .checkStamp(_):
        return .run { [state = state] send in
          guard let challenge = state.challenge else {
            return
          }
          
          // ✅ 50m 이내 명소만 필터링
          let nearAttractions = challenge.attractions
            .filter { ($0.distance ?? 1000) < 50 }

          guard !nearAttractions.isEmpty else {
            await send(.notNearAttraction)
            return
          }
          
          // ✅ 도장 찍기 API 호출
          var updatedAttraction: [Attraction] = []
          var updated = challenge
          
          for (i, attraction) in updated.attractions.enumerated() {
            guard !attraction.isStamped, // ✅ 이미 도장 찍은 경우는 skip
                  let distance = attraction.distance,
                  distance < 50  else { continue
            }
            do {
              let result = try await attractionClient.stamp(attraction.id, attraction.name)
              if result.isProcessed {
                updated.attractions[i].isStamped = true
                updated.attractions[i].stampCount += 1
                updated.myStampCount += 1
                updatedAttraction.append(updated.attractions[i])
              } else {
                logger.error("Stamp API 실패: \(attraction.id)")
              }
            } catch {
              logger.error("Stamp API 실패: \(attraction.id)")
            }
          }
          
          if updatedAttraction.count > 0 {
            // ✅ 반영된 상태 업데이트
            await send(.update(updated))
            await send(.completeStamp(updatedAttraction))
          } else {
            await send(.notNearAttraction)
          }
        }
        
      case let .bottomAction(action):
        switch action {
        case .like:
          if TokenManager.shared.isLogin {
            return .run { [state = state] send in
              guard let challenge = state.challenge else { return }
              
              // 1. 좋아요 UI 즉시 업데이트
              var update = challenge
              update.isLiked.toggle()
              update.likes = max(0, update.likes + (update.isLiked ? 1 : -1))
              await send(.update(update))
              
              do {
                let response = try await challengeClient.putLike(update.id)
                
                // 필요시 서버 데이터랑 다르면 다시 fetch
                if response.isLiked != update.isLiked {
                  let fresh = try await challengeClient.get(response.id)
                  await send(.update(fresh))
                }
              } catch {
                await send(.networkError)
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
          return .run { send in
            if let coordinate = AppSettingManager.shared.coordinate {
              await send(.checkStamp(coordinate))
            } else {
              let result = await locationClient.getCurrentLocation()
              await send(.locationResult(result))
              
              switch result {
              case let .success(coordinate):
                await send(.checkStamp(coordinate))
              case .fail:
                await send(.locationRequired)
              }
            }
          }
          
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
        return .none
        
      case .tappedAttraction:
        // Main TAb Navigation
        return .none
        
      case .locationResult(.fail):
        return .none
        
      case let .tappedAllComments(id, isFocus):
        return .send(.moveToAllComment(id: id, comment: nil, isFocus: isFocus))
        
      case let .tappedEditComment(id, comment):
        return .send(.moveToAllComment(id: id, comment: comment, isFocus: true))
        
      case .tappedDeleteComment(let id):
        state.deletingComment = id
        return .none
        
      case .cancelDeleteComment:
        state.deletingComment = nil
        return .none
        
      case let .deleteComment(id):
        state.deletingComment = nil
        return .run { [state = state] send in
          guard let challenge = state.challenge else { return }
          
          do {
            let result = try await commentClient.delete(id)
            if result.isProcessed {
              var updated = challenge
              updated.comments.removeAll(where: { $0.id == result.id })
              updated.commentCount = max(0, updated.commentCount - 1)
              await send(.update(updated))
              await send(.showToast(.deleteComplete))
            } else {
              await send(.networkError)
            }
          } catch {
            await send(.networkError)
          }
        }
        
      case .moveToAllComment:
        // Main Tab 에서 Navigation
        return .none
        
      case .notNearAttraction:
        return .send(.showToast(.notNearAttraction))
        
      case .locationRequired:
        // TODO: - 위치 미허용 처리
        return .send(.showToast(.notNearAttraction))
        
      case let .showToast(toast):
        state.showToast = toast
        return .run { send in
          try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
          await send(.dismissToast)
        }
        
      case .dismissToast:
        state.showToast = nil
        return .none
        
      case let .completeStamp(attractions):
        state.updateAttractions = attractions
        return .none
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
