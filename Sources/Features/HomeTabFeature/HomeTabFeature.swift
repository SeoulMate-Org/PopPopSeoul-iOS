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
    var bannerList: [Challenge] = []
    
    // Location
    var locationListType: LocationListType = .none
    var locationList: [Challenge] = []
    
    // Theme
    var loadingThemes: [ChallengeTheme] = [] // ✅ 로딩 중인 테마
    var selectedTheme: ChallengeTheme = .mustSeeSpots
    var themeChallenges: [ChallengeTheme: [Challenge]] = Dictionary(uniqueKeysWithValues: ChallengeTheme.sortedByPriority().map { ($0, []) })
    
    // Missing List
    var missingList: [Challenge] = []
    
    // Similar List
    var similarAttraction: String = ""
    var similarList: [Challenge] = []
    
    // Rnaking List
    var rankList: [Challenge] = []
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
    case updateLocationList([Challenge])
    
    // Theme List
    case themeChanged(ChallengeTheme)
    case fetchThemeList(ChallengeTheme)
    case updateThemeList(ChallengeTheme, [Challenge])
    case tappedThemeMore
    case moveToThemeChallenge(ChallengeTheme)
    
    // Missing List
    case fetchMissingList
    case updateMissingList([Challenge])
    
    // Similar List
    case fetchSimilarList
    case updateSimilarList(String, [Challenge])
    
    // Rnaking List
    case fetchRankList
    case updateRankList([Challenge])
    case tappedRankMore
    case moveToRank
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
          ),
          
          .run { send in
            await send(.fetchMissingList)
          },
          
          .run { send in
            await send(.fetchSimilarList)
          },
          
          .run { send in
            await send(.fetchRankList)
          }
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
        
        // MARK: - Theme Reducer
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
        
      case .tappedThemeMore:
        return .send(.moveToThemeChallenge(state.selectedTheme))
        
        // MARK: - Missing Reducer
      case .fetchMissingList:
        if TokenManager.shared.isLogin {
          return .run { send in
            do {
              let list = try await callengeListClient.fetchMissingList()
              await send(.updateMissingList(list))
            } catch {
              await send(.networkError)
            }
          }
        } else {
          state.missingList = []
          return .none
        }
        
      case let .updateMissingList(list):
        state.missingList = list
        return .none
        
        // MARK: - Similar Reducer
      case .fetchSimilarList:
        return .run { send in
          do {
            let result = try await callengeListClient.fetchSimilarList()
            if let attraction = result.attraction {
              await send(.updateSimilarList(attraction, result.list))
            } else {
              await send(.updateSimilarList("", []))
            }
          } catch {
            await send(.networkError)
          }
        }
        
      case let .updateSimilarList(attraction, list):
        state.similarAttraction = attraction
        state.similarList = list
        return .none
        
        // MARK: - Rank Reducer
      case .fetchRankList:
        return .run { send in
          do {
            let list = try await callengeListClient.fetchRankList()
            await send(.updateRankList(list))
          } catch {
            await send(.networkError)
          }
        }
        
      case let .updateRankList(list):
        state.rankList = list
        return .none
        
      case .tappedRankMore:
        return .send(.moveToRank)
        
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
