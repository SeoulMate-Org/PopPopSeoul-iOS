import Foundation
import ComposableArchitecture
import ComposableCoreLocation
import Common
import Clients

@Reducer
public struct HomeTabFeature {
  public init() {}
  
  @Dependency(\.continuousClock) var clock
  @Dependency(\.locationManager) var locationManager
  
  // MARK: - State
  
  @ObservableState
  public struct State: Equatable {
    public init() {}
    
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    var userLocation: Coordinate?
  }
  
  // MARK: - Action
  
  @CasePathable
  public enum Action: Equatable {
    case onAppear
    case locationManager(LocationManager.Action)
  }
  
  // MARK: - Reducer
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return .merge(
          // 1. 권한 요청
          .run { _ in await locationManager.requestWhenInUseAuthorization() },
          
          // 2. delegate로부터 변경 사항 감지
          .run { send in
            for await action in await locationManager.delegate() {
              await send(.locationManager(action), animation: .default)
            }
          }
        )

      case let .locationManager(.didChangeAuthorization(status)):
        state.authorizationStatus = status
        if status == .authorizedAlways || status == .authorizedWhenInUse {
          return .run { _ in await locationManager.requestLocation() }
        } else {
          return .none
        }
        
      case let .locationManager(.didUpdateLocations(locations)):
        if let location = locations.first {
          state.userLocation = Coordinate(location.coordinate)
        }
        return .none
        
      default: return .none
      }
    }
  }
}

// MARK: - Helper

enum LocationManagerKey: DependencyKey {
  static let liveValue = LocationManager.live
  static let testValue = LocationManager.failing
}

public extension DependencyValues {
  var locationManager: LocationManager {
    get { self[LocationManagerKey.self] }
    set { self[LocationManagerKey.self] = newValue }
  }
}
