import ComposableArchitecture

@Reducer
public struct AppFeature {
  public init() {}
  
  @Reducer
  public enum Destination {
    case intro(IntroFeature)
  }
  
  // MARK: State
  
  @ObservableState
  public struct State {
    // Navigation
    @Presents var destination: Destination.State?
  }
  
  // MARK: Actions
  
  public enum Action {
    case destination(PresentationAction<Destination.Action>)
    case onAppear
  }
  
  // MARK: Reducer
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        state.destination = .intro(IntroFeature.State())
        return .none
        
      case .destination:
        return .none
      }
    }
//    .presentation(
//      destination: \.$destination,
//      action: \.destination,
//      reducer: Destination.init
//    )
  }
}
