//
//  SplashFeature.swift
//  Clients
//
//  Created by suni on 4/22/25.
//

import Foundation
import ComposableArchitecture
import Common
import Clients

@Reducer
public struct SplashFeature {
  public init() {}
  
  @Dependency(\.appUpdateClient) var appUpdateClient
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
    
    case showForceUpdateAlert
    
    case alert(PresentationAction<Alert>)
    
    public enum Alert: Equatable {
      case goToUpdateTapped
    }
  }
  
  // MARK: - Reducer
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        
      case .onAppear:
        return .send(.checkRouting)
        
      case .checkRouting:
        return .send(.didFinishRoutingCheck)
        
      case .didFinishRoutingCheck:
        return .send(.checkAppUpdate)
        
      case .checkAppUpdate:
        return .run { send in
          let (updateType, _) = try await appUpdateClient.checkForUpdate()
          
          if updateType == .forceUpdate {
            await send(.showForceUpdateAlert)
          } else {
            try? await clock.sleep(for: .seconds(1))
            await send(.didFinish)
          }
        }
      
      case .showForceUpdateAlert:
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
        
      case .didFinish:
        return .none
        
      case .alert(.presented(.goToUpdateTapped)):
        // TODO: - 👉 앱스토어 이동 처리
        print("앱스토어로 이동")
        return .none
        
      default: return .none
      }
    }
    .ifLet(\.$alert, action: \.alert)
  }
}

// MARK: - Helper
