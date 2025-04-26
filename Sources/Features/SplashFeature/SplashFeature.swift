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
import Models

@Reducer
public struct SplashFeature {
  public init() {}
  
  @Dependency(\.appUpdateClient) private var appUpdateClient
  @Dependency(\.userDefaultsClient) private var userDefaultsClient
  @Dependency(\.authClient) private var authClient
  @Dependency(\.continuousClock) private var clock
  
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
    case checkRouting // 루팅 체크
    case didFinishRoutingCheck // 루팅 체크 완료
    case checkAppUpdate // 업데이트 체크
    
    case initializeApp // 앱 초기 상태 세팅
    case didFinishInitLaunch // 스플레시 완료 - 첫 진입
    case didFinish(Bool) // 스플레시 완료
    
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
            await send(.initializeApp)
          }
        }
        
      case .initializeApp:
        AppSettingManager.shared.initLanguage()
        
        return .run { send in
          if await AppSettingManager.shared.hasInitLaunch() {
            var isLogin: Bool = false
            
            do {
              try await authClient.refresh()
              isLogin = true
            } catch {
              isLogin = false
            }
            
            await send(.didFinish(isLogin))
            
          } else {
            await userDefaultsClient.setHasLaunch(true)
            await send(.didFinishInitLaunch)
            
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
        
      case .alert(.presented(.goToUpdateTapped)):
        Utility.moveAppStore()
        return .none
        
      default: return .none
      }
    }
    .ifLet(\.$alert, action: \.alert)
  }
}

// MARK: - Helper

