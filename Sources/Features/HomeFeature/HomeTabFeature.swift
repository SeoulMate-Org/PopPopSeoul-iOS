import Foundation
import ComposableArchitecture
import ComposableCoreLocation
import Common
import Clients
import Models
import SharedTypes

@Reducer
public struct HomeTabFeature {
  public init() {}
  
  @Dependency(\.continuousClock) var clock
  @Dependency(\.locationManager) var locationManager
  @Dependency(\.callengeListClient) var callengeListClient
  
  // MARK: - State
  
  @ObservableState
  public struct State: Equatable {
    public init() {}
    
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    var userCoordinate: Coordinate?
    
    // Banner
    var bannerList: [MyChallenge] = []
    
    // Location
    var locationListType: LocationListType = .none
    var locationList: [MyChallenge] = []
    
    // Theme
    var loadingThemes: [ChallengeTheme] = [] // ✅ 로딩 중인 테마
    var selectedTheme: ChallengeTheme = .mustSeeSpots
    var themeChallenges: [ChallengeTheme: [MyChallenge]] = Dictionary(uniqueKeysWithValues: ChallengeTheme.sortedByPriority().map { ($0, []) })
    
  }
  
  public enum LocationListType: Equatable {
    case list
    case loginRequired
    case locationAuthRequired
    case defaultList
    case none
  }
  
  // MARK: - Action
  
  @CasePathable
  public enum Action: Equatable {
    case onAppear
    case networkError
    case tappedChallenge(id: Int)
    
    // Banner
    case fetchBannerList
    case fetchExplorationList // 탐방형
    case fetchParticipationList // 참여형
    
    // Location List
    case locationManager(LocationManager.Action)
    case updateUserCoordinate(Coordinate)
    case updateLocationListType(LocationListType)
    case fetchLocationList(Coordinate)
    case updateLocationList([MyChallenge])
    
    // Theme List
    case themeChanged(ChallengeTheme)
    case fetchThemeList(ChallengeTheme)
    case updateThemeList(ChallengeTheme, [MyChallenge])
    
    // Missing List
    case fetchMissingList
    
    // Similar List
    case fetchSimilarList
    
    // Rnaking List
    case fetchRankingList
  }
  
  // MARK: - Reducer
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        let prefetchThemes: [ChallengeTheme] = [.mustSeeSpots, .localTour, .historyCulture]
        return .merge(
          // 1. 권한 요청
          .run { _ in await locationManager.requestWhenInUseAuthorization() },
          
          // 2. delegate로부터 변경 사항 감지
          .run { send in
            for await action in await locationManager.delegate() {
              await send(.locationManager(action), animation: .default)
            }
          },
          
          // 3. 현재 권한 상태 직접 조회
          .run { send in
            let status = await locationManager.authorizationStatus()
            await send(.locationManager(.didChangeAuthorization(status)))
          },
          
          .merge(
            prefetchThemes.map { .send(.fetchThemeList($0)) }
          )
        )
        
      case let .locationManager(.didChangeAuthorization(status)):
        guard state.authorizationStatus != status else { return .none }
        
        state.authorizationStatus = status
        if status == .authorizedAlways || status == .authorizedWhenInUse {
          return .run { send in
            // 위치 허용
            if TokenManager.shared.isLogin {
              await locationManager.requestLocation()
            } else {
              await send(.updateLocationListType(.loginRequired))
            }
          }
        } else {
          // 위치 비허용
          return .run { send in
            await send(.updateLocationListType(.locationAuthRequired))
          }
        }
        
      case let .locationManager(.didUpdateLocations(locations)):
        return .run { send in
          if let location = locations.first {
            await send(.updateLocationListType(.list))
            await send(.updateUserCoordinate(Coordinate(location.coordinate)))
          } else {
            await send(.updateLocationListType(.defaultList))
            await send(.updateUserCoordinate(Coordinate()))
          }
        }
        
      case let .updateUserCoordinate(coordinate):
        state.userCoordinate = coordinate
        return .run { send in
          await send(.fetchLocationList(coordinate))
        }
        
      case let .updateLocationListType(type):
        state.locationListType = type
        
        if state.locationListType != .defaultList ||
            state.locationListType != .list {
          state.locationList = []
        }
        return .none
        
      case let .fetchLocationList(coordinate):
        return .run { send in
          do {
            let list = try await callengeListClient.fetchLocationList(coordinate)
            await send(.updateLocationList(list))
          } catch {
            await send(.networkError)
          }
        }
        
      case let .updateLocationList(list):
        state.locationList = list
        return .none
        
      case let .themeChanged(theme):
        state.selectedTheme = theme
        if state.themeChallenges[theme]?.isEmpty == true && !state.loadingThemes.contains(theme) {
          return .send(.fetchThemeList(theme))
        }
        return .none
        
      case let .fetchThemeList(theme):
        state.loadingThemes.append(theme)
        return .run { send in
          do {
            let result = try await callengeListClient.fetchThemeList(theme)
            await send(.updateThemeList(result.0, result.1))
          } catch {
            await send(.networkError)
          }
        }
        
      case let .updateThemeList(theme, list):
        state.loadingThemes.removeAll(where: { $0.id == theme.id })
        state.themeChallenges[theme] = list
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
