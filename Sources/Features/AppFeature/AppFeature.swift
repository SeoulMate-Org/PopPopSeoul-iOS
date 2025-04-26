import ComposableArchitecture
import Clients
import Models
import SharedTypes

@Reducer
public struct AppFeature {
  public init() {}
  
  @Dependency(\.userDefaultsClient) var userDefaultsClient
    
  @Reducer(state: .equatable, action: .equatable)
  public enum Destination {
    case splash(SplashFeature)
    case onboarding(OnboardingFeature)
    case mainTab(MainTabFeature)
    case login(LoginFeature)
  }
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    var isLogin: Bool?
    
    // Navigation
    @Presents public var destination: Destination.State?
    
    public init() {
      self.destination = .splash(.init()) // 앱 첫 진입 화면
    }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action {
    // Navigation
    case destination(PresentationAction<Destination.Action>)
  }
  
  // MARK: Reducer
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .destination(.presented(.splash(.didFinishInitLaunch))):
        state.destination = .onboarding(.init())
        return .none
        
      case .destination(.presented(.splash(.didFinish(let isLogin)))):
        state.isLogin = isLogin
        state.destination = .mainTab(.init())
        return .none
        
      case .destination(.presented(.onboarding(.didFinish))):
        state.destination = .login(.init())
        return .none
        
      case .destination(.presented(.login(.aroundTapped))):
        state.destination = .mainTab(.init())
        return .none
        
      case .destination(.presented(.login(.successLogin(let isInit)))):
        if isInit {
          // TODO: - 회원 가입 축하 화면
          state.destination = .mainTab(.init())
        } else {
          state.destination = .mainTab(.init())
        }
        return .none
        
      case .destination:
        return .none
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }
}
