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
  @Dependency(\.userClient) var userClient
  
  // MARK: - State
  
  @ObservableState
  public struct State: Equatable {
    public init() {
      self.isLogin = TokenManager.shared.isLogin
    }
    
    public var onAppearType: OnAppearType = .firstTime
    
    var language: AppLanguage = .kor
    var appVersion: String = ""
    var isLogin: Bool
    var user: User?
    var isLocationAuth: Bool  = false
    var showAlert: Alert?
  }
  
  public enum Alert: Equatable {
    case login
    case logout
    case onLocation
    case offLocation
  }
  
  // MARK: - Action
  
  @CasePathable
  public enum Action: Equatable {
    case initialize
    case networkError
    
    case fetchUser
    case update(User)
    case requestLocation
    case updateLocationAuth(Bool)
    
    case showAlert(Alert)
    case tappedAlertCancel
    
    case move(MoveAction)
    case moveWeb(MoveWeb)
    
    case tappedNickname
    case tappedLoginCheckMove(MoveAction)
    case toggleLocationAuth(Bool)
    case tappedLogout
    case tappetGoToSetting
  }
  
  public enum MoveWeb: Equatable {
    case faq
    case termsOfService
    case privacyPolicy
    case locationPrivacy
  }
  
  public enum MoveAction: Equatable {
    case nicknameSetting(User)
    case badge
    case likeAttraction
    case comment
    case language(AppLanguage)
    case notification
    case onboarding
    case withdraw
  }
  // MARK: - Reducer
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .initialize:
        state.language = AppSettingManager.shared.language
        state.appVersion = Constants.appVersion
        return .merge(
          .run { send in
            await send(.fetchUser)
          },
          .run { send in
            await send(.requestLocation)
          }
        )
        
      case .networkError:
        // TODO: - Network Error 처리
        return .none
        
      case .fetchUser:
        return .run { send in
          do {
            let user = try await userClient.fetch()
            await send(.update(user))
          } catch {
            await send(.networkError)
          }
        }
        
      case let .update(user):
        state.user = user
        return .none
        
      case .requestLocation:
        return .run { send in
          let status = await locationClient.getAuthorizationStatus()
          
          if status ==  .authorizedAlways || status == .authorizedWhenInUse {
            //            if userDefaultsClient.isLocationRequestBlocked {
            //              await send(.updateLocationAuth(false))
            //            } else {
            await send(.updateLocationAuth(true))
            //            }
          } else {
            await send(.updateLocationAuth(false))
          }
        }
        
      case let .updateLocationAuth(isAuth):
        state.isLocationAuth = isAuth
        return .none
        
      case .tappedNickname:
        if let user = state.user {
          return .send(.move(.nicknameSetting(user)))
        } else {
          return .send(.showAlert(.login))
        }
        
      case let .toggleLocationAuth(isOn):
        if isOn {
          return .none
        } else {
          return .none
        }
        
        // MARK: - Move Action
      case .move:
        // Main Navigation
        return .none
        
      case let .showAlert(alert):
        state.showAlert = alert
        return .none
        
      case let .moveWeb(web):
        switch web {
        case .faq:
          return .none
        case .termsOfService:
          return .none
        case .privacyPolicy:
          return .none
        case .locationPrivacy:
          return .none
        }
        
      case let .tappedLoginCheckMove(action):
        if TokenManager.shared.isLogin {
          return .send(.move(action))
        } else {
          return .none
        }
        
      case .tappedLogout:
        // TODO: Logout
        return .none
        
      case .tappedAlertCancel:
        state.showAlert = nil
        return .none
        
      case .tappetGoToSetting:
        Utility.moveAppSetting()
        return .none
      }
    }
  }
}
