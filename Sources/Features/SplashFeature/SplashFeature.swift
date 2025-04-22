//
//  SplashFeature.swift
//  Clients
//
//  Created by suni on 4/22/25.
//

import Foundation
import ComposableArchitecture
import Common

@Reducer
public struct SplashFeature {
  public init() {}
  
  @Dependency(\.continuousClock) var clock
  
  // MARK: - State
  
  @ObservableState
  public struct State: Equatable {
    @Presents public var alert: AlertState<Action.Alert>?
    
    public init() {}
  }
  
  // MARK: - Action
  
  @CasePathable
  public enum Action: Equatable {
    case onAppear
    case checkRouting
    case didFinishRoutingCheck
    case checkAppUpdate
    case didFinish
    
    case alert(PresentationAction<Alert>)
    
    @CasePathable
    public enum Alert: Equatable {
      case goToUpdateTapped
    }
  }
  
  // MARK: - Reducer
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        
      case .onAppear:
        logs.debug("onAppear 실행") // 여기서 실행되지 않음!!
        return .send(.checkRouting)
        
      case .checkRouting:
        return .send(.didFinishRoutingCheck)
        
      case .didFinishRoutingCheck:
        return .send(.checkAppUpdate)
        
      case .checkAppUpdate:
        let updateNeeded = true // ✅ 실제 업데이트 필요 여부 체크 로직으로 대체
        
        if updateNeeded {
          state.alert = AlertState(
            title: { TextState("업데이트")
            }, actions: {
              ButtonState(action: .goToUpdateTapped) {
                TextState("업데이트 하러가기")
              }
            }, message: {
              TextState("앱을 사용하려면 업데이트가 필요합니다.")
            })
          return .none
          
        } else {
          state.alert = nil
          
          return .run { send in
            try? await clock.sleep(for: .seconds(1))
            await send(.didFinish)
          }
        }
        
      case .didFinish:
        return .none
        
      case .alert(.presented(.goToUpdateTapped)):
        // 👉 앱스토어 이동 처리
        print("앱스토어로 이동")
        return .none
        
      default: return .none
      }
    }
  }
}

// MARK: - Helper
