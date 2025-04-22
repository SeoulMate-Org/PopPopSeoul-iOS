import ComposableArchitecture

@Reducer
public struct AppFeature {
  public init() {}
    
  @Reducer(state: .equatable, action: .equatable)
  public enum Route {
    case launching
    case mainTab
  }
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    public init() {}
    
    // Navigation
    var route: Route = .launching
    var splash: SplashFeature.State = .init()
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onAppear
    
    // Navigation
    case routeChanged(Route)
    case splash(SplashFeature.Action)
  }
  
  // MARK: Reducer
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.splash, action: \.splash) {
      SplashFeature()
    }
    
    Reduce { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case let .routeChanged(route):
        state.route = route
        return .none
        
      case .splash(.didFinish): // ✅ 여기서 감지!
        state.route = .mainTab // 또는 .onboarding 등
        return .none
        
      default: return .none
      }
    }
  }
}
