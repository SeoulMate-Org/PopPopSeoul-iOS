//
//  MyChallengeFeature.swift
//  Common
//
//  Created by suni on 4/18/25.
//

import Foundation
import ComposableArchitecture
import Common

@Reducer
public struct MyChallengeFeature {
  public init() {}
  
  // MARK: State

  @ObservableState
  public struct State: Equatable {
    public var tab: Tab = .interest

    public enum Tab: CaseIterable {
      case interest
      case progress
      case completed
    }
    
    var interestList: [Challenge] = []
    var progressList: [Challenge] = []
    var completedList: [Challenge] = []
    var recentlyDeleted: Challenge? = nil
    var showUndoToast: Bool = false
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case tabChanged(State.Tab)
    case fetchList // 최초 또는 새로고침 시
    case setInterestList([Challenge])
    case undoLike
    case dismissToast
    case tappedInterest(id: UUID)
    case setProgressList([Challenge])
    case setCompletedList([Challenge])
  }
  
  // MARK: Reducer
  
  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .tabChanged(let tab):
        state.tab = tab
        return .none

      case .fetchList:
        // 실제 API 연동 부분 또는 더미 데이터 삽입
        return .run { send in
          async let interest: () = send(.setInterestList(mockChallenges))
          async let progress: () = send(.setProgressList(mockChallenges))
          async let completed: () = send(.setCompletedList(mockChallenges))
          _ = await (interest, progress, completed)
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
      }
    }
  }
}

// MARK: - Helper
//@Reducer
//public struct AppFeature {
//  public init() {}
//  
//  // MARK: State
//  
//  @ObservableState
//  public struct State {
//    var path = StackState<Path.State>()
//  }
//  
//  // MARK: Actions
//  
//  public enum Action {
//    case path(StackActionOf<Path>)
//  }
//  
//  @Reducer
//  public enum Path {
//    case splash(SplashFeature)
//  }
//  
//  // MARK: Reducer
//  
//  var body: some ReducerOf<Self> {
//    Reduce { state, action in
//      // TODO: -
//      return .none
//    }
//    .forEach(\.path, action: \.path)
//  }
//}
