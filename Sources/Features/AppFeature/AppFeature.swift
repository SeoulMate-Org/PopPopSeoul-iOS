import ComposableArchitecture
import Clients

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
    // Navigation
    @Presents public var destination: Destination.State?
    
    public init() {
      self.destination = .splash(.init()) // 앱 첫 진입 화면
    }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    // Navigation
    case destination(PresentationAction<Destination.Action>)
  }
  
  // MARK: Reducer
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .destination(.presented(.splash(.didFinish))):
        if userDefaultsClient.hasSeenOnboarding {
          // TODO: AutoLogin Check
          state.destination = .mainTab(.init())
        } else {
          // 온보딩 체크
          state.destination = .onboarding(.init())
        }
        return .none
        
      case .destination(.presented(.onboarding(.didFinish))):
        state.destination = .login(.init())
        return .none
        
      case .destination:
        return .none
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }
}
