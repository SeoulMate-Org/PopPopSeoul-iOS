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
  @Dependency(\.authClient) var authClient
  
  // MARK: - State
  
  @ObservableState
  public struct State: Equatable {
    public var onAppearType: OnAppearType = .firstTime
    
    var language: AppLanguage = .kor
    var appVersion: String = ""
    var isLogin: Bool = false
    var user: User?
    var isLocationAuth: Bool  = false
    var showAlert: Alert?
    var showWeb: Web?
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
    case tappedFAQ
    case tappedTermsOfService
    case tappedPrivacyPolicy
    case tappedLocationPrivacy
    case showWeb(Web)
    case dismissWeb
    
    case tappedNickname
    case tappedLoginCheckMove(MoveAction)
    case toggleLocationAuth(Bool)
    case tappedLogout
    case tappetGoToSetting
  }
  
  public enum Web: Equatable, Identifiable {
    case faq(url: URL)
    case termsOfService(url: URL)
    case privacyPolicy(url: URL)
    case locationPrivacy(url: URL)
    
    public var id: String {
      switch self {
      case .faq: return "faq"
      case .termsOfService: return "terms"
      case .privacyPolicy: return "privacy"
      case .locationPrivacy: return "location"
      }
    }
  }
  
  public enum MoveAction: Equatable {
    case nicknameSetting(String)
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
        state.isLogin = TokenManager.shared.isLogin
        state.language = AppSettingManager.shared.language
        state.appVersion = Constants.appVersion
        
        if state.isLogin {
          return .merge(
            .run { send in
              await send(.fetchUser)
            },
            .run { send in
              await send(.requestLocation)
            }
          )
        } else {
          state.user = nil
          return .run { send in
            await send(.requestLocation)
          }
        }
        
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
          return .send(.move(.nicknameSetting(user.nickname)))
        } else {
          return .send(.showAlert(.login))
        }
        
      case let .toggleLocationAuth(isOn):
        state.isLocationAuth = isOn
        if isOn {
          return .send(.showAlert(.onLocation))
        } else {
          return .send(.showAlert(.offLocation))
        }
        
        // MARK: - Move Action
      case .move:
        // Main Navigation
        return .none
        
      case let .showAlert(alert):
        state.showAlert = alert
        return .none
        
      case let .showWeb(web):
        state.showWeb = web
        return .none
        
      case .dismissWeb:
        state.showWeb = nil
        return .none
        
      case .tappedFAQ:
        if state.language == .kor {
          return .send(.showWeb(.faq(url: URL(string: "https://early-palladium-c40.notion.site/1e3bde6bd69580c89725e7b2399baadb?pvs=74")!)))
        } else {
          return .send(.showWeb(.faq(url: URL(string: "https://early-palladium-c40.notion.site/Seoul-Tourism-FAQ-1e3bde6bd6958018b538c35bf630ca0b")!)))
        }
      case .tappedTermsOfService:
        if state.language == .kor {
          return .send(.showWeb(.faq(url: URL(string: "https://early-palladium-c40.notion.site/1e3bde6bd6958065a15fc07db4fb67d1?pvs=74")!)))
        } else {
          return .send(.showWeb(.faq(url: URL(string: "https://early-palladium-c40.notion.site/Terms-and-Conditions-of-Service-1e3bde6bd695809c8437f8d794829836?pvs=74")!)))
        }
        
      case .tappedPrivacyPolicy:
        if state.language == .kor {
          return .send(.showWeb(.faq(url: URL(string: "https://early-palladium-c40.notion.site/1e3bde6bd69580acbecdd6e595e1f7b8")!)))
        } else {
          return .send(.showWeb(.faq(url: URL(string: "https://early-palladium-c40.notion.site/Privacy-Policy-1e3bde6bd69580bcb074c603910d8c55")!)))
        }
        
      case .tappedLocationPrivacy:
        if state.language == .kor {
          return .send(.showWeb(.faq(url: URL(string: "https://early-palladium-c40.notion.site/1e3bde6bd6958076ac0ac01e78dda837?pvs=74")!)))
        } else {
          return .send(.showWeb(.faq(url: URL(string: "https://early-palladium-c40.notion.site/Location-Information-Processing-Policy-1e3bde6bd69580609698fd3b570eb124?pvs=74")!)))
        }
        
      case let .tappedLoginCheckMove(action):
        if TokenManager.shared.isLogin {
          return .send(.move(action))
        } else {
          return .send(.showAlert(.login))
        }
        
      case .tappedLogout:
        return .run { send in
          do {
            try await authClient.logout()
            await send(.initialize)
          } catch {
            await send(.networkError)
          }
        }
        
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
