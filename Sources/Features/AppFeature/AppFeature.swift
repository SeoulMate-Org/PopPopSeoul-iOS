import ComposableArchitecture

@Reducer
public struct AppFeature: Reducer {
  public init() {}
  
  @Dependency(\.continuousClock) var clock
  
  @Reducer
  public enum Destination {
    case alert(AlertState<Alert>)
    
    public enum Alert: Equatable {
      case forceUpdate
      case latestUpdate
    }
  }
  
  public enum Route {
    case launching
    case mainTab
  }
  
  // MARK: State
  
  @ObservableState
  public struct State {
    public init() {}
    
    // Navigation
    var route: Route = .launching
    var mainTab: MainTabFeature.State = .init()
    @Presents var destination: Destination.State?
  }
  
  // MARK: Actions
  
  public enum Action {
    case onAppear
    
    // Navigation
    case routeChanged(Route)
    case mainTab(MainTabFeature.Action)
    case destination(PresentationAction<Destination.Action>)
  }
  
  // MARK: Reducer
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return .run { send in
          //          let updateNeeded = await checkAppUpdate()
          // TODO: - Update Check
          let updateNeeded = false
          if updateNeeded {
            await send(.destination(.presented(.alert(.forceUpdate))))
          } else {
            try? await clock.sleep(for: .seconds(2))
            await send(.routeChanged(.mainTab))
          }
        }
        
      case let .routeChanged(route):
        state.route = route
        return .none
        
      case .destination:
        return .none
        
      case .mainTab:
        return .none
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }
}
