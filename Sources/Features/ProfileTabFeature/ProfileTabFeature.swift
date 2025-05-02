import Foundation
import ComposableArchitecture
import ComposableCoreLocation
import Common
import Clients
import Models
import SharedTypes

@Reducer
public struct ProfileTabFeature {
  public init() { }
  
  @Dependency(\.userDefaultsClient) var userDefaultsClient
  @Dependency(\.locationClient) var locationClient
  
  // MARK: - State
  
  @ObservableState
  public struct State: Equatable {
    public init() { }
    
    public var onAppearType: OnAppearType = .firstTime
    
    var language: AppLanguage = .kor
    var user: User?
    var isLocationAuth: Bool  = false
  }
  
  // MARK: - Action
  
  @CasePathable
  public enum Action: Equatable {
    case initialize
    
    case requestLocation
    case updateLocationAuth(Bool)
    
    case tappedNickname
    case showLoginAlert
    case moveToNicknameSetting(User)
    case locationAuthToggle(Bool)
  }
  // MARK: - Reducer
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .initialize:
        // TODO: - API 연동
        state.user = User(id: 1, nickname: "닉네임", loginType: "FACEBOOK", badgeCount: 0, likeCount: 0, commentCount: 0)
        state.language = AppSettingManager.shared.language
        return .none
        
      case .requestLocation:
        return .run { send in
          let status = await locationClient.getAuthorizationStatus()
          
          if status ==  .authorizedAlways || status == .authorizedWhenInUse {
            if userDefaultsClient.isLocationRequestBlocked {
              await send(.updateLocationAuth(false))
            } else {
              await send(.updateLocationAuth(true))
            }
          } else {
            await send(.updateLocationAuth(false))
          }
        }
        
      case let .updateLocationAuth(isAuth):
        state.isLocationAuth = isAuth
        return .none
        
      case .tappedNickname:
        if let user = state.user {
          return .send(.moveToNicknameSetting(user))
        } else {
          return .send(.showLoginAlert)
        }
        
      case .moveToNicknameSetting:
        // Main Navigation
        return .none
        
      case .showLoginAlert:
        // Main Navigation
        return .none
        
      case .locationAuthToggle(_):
        return .none
      }
    }
  }
}
