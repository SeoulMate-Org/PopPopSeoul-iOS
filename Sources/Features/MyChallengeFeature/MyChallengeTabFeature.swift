//
//  MyChallengeTabFeature.swift
//  Common
//
//  Created by suni on 4/18/25.
//

import Foundation
import ComposableArchitecture
import Common
import SharedTypes
import Clients
import Models

@Reducer
public struct MyChallengeTabFeature {
  public init() {}
  
  @Dependency(\.myChallengeClient) var myChallengeClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    var selectedTab: Tab = .interest
    
    var interestList: [MyChallenge] = []
    var progressList: [MyChallenge] = []
    var completedList: [MyChallenge] = []
    
    var recentlyDeleted: MyChallenge? = nil
    var showUndoToast: Bool = false
  }
  
  public enum Tab: Equatable, CaseIterable {
    case interest
    case progress
    case completed
    
    public var apiCode: String {
      switch self {
      case .interest: return "LIKE"
      case .progress: return "PROGRESS"
      case .completed: return "COMPLETE"
      }
    }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onApear
    case tabChanged(Tab)
    case fetchList(Tab)
    case fetchListError
    
    case undoLike
    case dismissToast
    case tappedInterest(id: Int)
    case tappedItem(id: Int)
    
    case setInterestList([MyChallenge])
    case setProgressList([MyChallenge])
    case setCompletedList([MyChallenge])
  }
  
  // MARK: Reducer
  
  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .onApear:
        return .send(.fetchList(state.selectedTab))
        
      case .tabChanged(let tab):
        state.selectedTab = tab
        return .send(.fetchList(tab))
        
      case .fetchList(let tab):
        return .run { send in
          switch tab {
          case .interest:
            do {
              let list = try await myChallengeClient.fetchList(tab.apiCode)
              await send(.setInterestList(list))
            } catch {
              await send(.fetchListError)
            }
          case .progress:
            do {
              let list = try await myChallengeClient.fetchList(tab.apiCode)
              await send(.setProgressList(list))
            } catch {
              await send(.fetchListError)
            }
          case .completed:
            do {
              let list = try await myChallengeClient.fetchList(tab.apiCode)
              await send(.setCompletedList(list))
            } catch {
              await send(.fetchListError)
            }
          }
        }
        
      case .setInterestList(let list):
        state.interestList = list
        return .none
        
      case .tappedInterest(id: let id):
        if let index = state.interestList.firstIndex(where: { $0.id == id }) {
          state.recentlyDeleted = state.interestList.remove(at: index)
          state.showUndoToast = true
          return .run { send in
            try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
            await send(.dismissToast)
          }
        }
        return .none
        
      case .undoLike:
        if let challenge = state.recentlyDeleted {
          state.interestList.insert(challenge, at: 0)
        }
        state.recentlyDeleted = nil
        state.showUndoToast = false
        return .none
        
      case .dismissToast:
        state.recentlyDeleted = nil
        state.showUndoToast = false
        return .none
        
      case .setProgressList(let list):
        state.progressList = list
        return .none
        
      case .setCompletedList(let list):
        state.completedList = list
        return .none
        
      case .fetchListError:
        // TODO: - ERROR
        return .none
        
      case .tappedItem:
        return .none
      }
    }
  }
}

// MARK: - Helper
