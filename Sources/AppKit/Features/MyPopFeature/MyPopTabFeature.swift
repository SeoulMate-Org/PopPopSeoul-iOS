//
//  MyPopFeature.swift
//  Common
//
//  Created by suni on 4/18/25.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct MyPopFeature {
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
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case tabChanged(State.Tab)
    case fetchList // 최초 또는 새로고침 시
    case setInterestList([Challenge])
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
          await send(.setInterestList(mockChallenges))
        }

      case .setInterestList(let list):
        state.interestList = list
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

