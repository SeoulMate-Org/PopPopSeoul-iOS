import ComposableArchitecture

@Reducer
public struct AppFeature {
  public init() {}
    
  @Reducer(state: .equatable, action: .equatable)
  public enum Destination {
    case splash(SplashFeature)
    case mainTab(MainTabFeature)
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
        state.destination = .mainTab(.init())
        return .none
        
      case .destination:
        return .none
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }
}
