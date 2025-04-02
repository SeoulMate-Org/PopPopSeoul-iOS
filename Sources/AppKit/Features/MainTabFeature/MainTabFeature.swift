//
//  MainTabFeature.swift
//  SeoulMateKit
//
//  Created by suni on 4/2/25.
//

import Foundation
import ComposableArchitecture

public struct MainTabFeature: Reducer {
  public struct State: Equatable {
    public var selectedTab: Tab = .theme

    public enum Tab {
      case theme, map, likes
    }
  }

  public enum Action: Equatable {
    case themeTapped
    case mapTapped
    case likesTapped
  }

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .themeTapped:
        state.selectedTab = .theme
        return .none
      case .mapTapped:
        state.selectedTab = .map
        return .none
      case .likesTapped:
        state.selectedTab = .likes
        return .none
      }
    }
  }
}
