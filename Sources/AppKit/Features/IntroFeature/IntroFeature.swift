import ComposableArchitecture

@Reducer
public struct IntroFeature {
  public init() {}
  
  // MARK: State
  
  @ObservableState
  public struct State {
    
  }
  
  // MARK: - Action
  
  public enum Action {
    case onAppear
    case appUpdateCheckCompleted(Bool)
    case didFinishIntro
  }
  
  // MARK: Reducer
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return .run { send in
          // TODO: Check App Update
          //          let updateNeeded = await checkAppUpdate()
          let updateNeeded = false
          await send(.appUpdateCheckCompleted(updateNeeded))
        }
        
      case let .appUpdateCheckCompleted(updateNeeded):
        if updateNeeded {
          // TODO: 업데이트 팝업 Alert 상태 등 추가 필요
          return .none
        } else {
          return .send(.didFinishIntro)
        }
        
      case .didFinishIntro:
        return .none
      }
    }
  }
}
