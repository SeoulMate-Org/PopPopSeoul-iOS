//
//  AppUpdateClient.swift
//  Clients
//
//  Created by suni on 4/22/25.
//

import Foundation
import ComposableArchitecture
import FirebaseCore
import FirebaseRemoteConfig
import FirebaseAnalytics
import Common

public enum AppUpdate: Equatable {
  case none
  case forceUpdate
}

public struct AppUpdateClient {
  public var checkForUpdate: @Sendable () async throws -> (AppUpdate, String?)
}

extension AppUpdateClient: DependencyKey {
  public static let liveValue: Self = {
    return Self(
      checkForUpdate: {
        return await withCheckedContinuation { continuation in
          checkForUpdate { update, storeVersion in
            continuation.resume(returning: (update, storeVersion))
          }
        }
      })
  }()
  
  enum AppVersionKey: String {
    case forceUpdateVersion
  }
  
  private static func latestVersion() -> String? {
    let appStoreId: String = Constants.appVersion
    
    guard let url = URL(string: "http://itunes.apple.com/lookup?id=\(appStoreId)&country=kr"),
          let data = try? Data(contentsOf: url),
          let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
          let results = json["results"] as? [[String: Any]],
          let appStoreVersion = results[0]["version"] as? String else {
      return nil
    }
    return appStoreVersion
  }
  
  private static func checkForUpdate(completion: @escaping (_ update: AppUpdate, _ storeVersion: String?) -> Void) {
    
    print("latestVersion \(latestVersion() ?? "nil")")
    
    let storeVersion = latestVersion() ?? "1.0.0"
    let currentVersion = Constants.appVersion
    let currentComponents = currentVersion.split(separator: ".").map { Int($0) ?? 0 }
    let storeComponents = storeVersion.split(separator: ".").map { Int($0) ?? 0 }
    for index in 0..<max(currentComponents.count, storeComponents.count) {
      let current = index < currentComponents.count ? currentComponents[index] : 0
      let new = index < storeComponents.count ? storeComponents[index] : 0
      
      if current < new {
        // 강제 업데이트 필요
        completion(.forceUpdate, storeVersion)
        return
      }
    }
    completion(.none, storeVersion)
    
    //    let remoteConfig = RemoteConfig.remoteConfig()
    //
    //#if DEBUG
    //    let settings = RemoteConfigSettings()
    //    settings.minimumFetchInterval = 0
    //    remoteConfig.configSettings = settings
    //#endif
    //
    //    remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
    //
    //    //     Remote Config 값 가져오기
    //    print("Get remoteConfig \(remoteConfig.description)")
    //
    //    remoteConfig.fetchAndActivate { status, error in
    //      print("Success featch remoteConfig \(status) \(String(describing: error))")
    //      guard error == nil else {
    //        completion(.none, nil)
    //        return
    //      }
    //
    //      // 값을 사용할 수 있습니다.
    //      let forceVersion = remoteConfig[AppVersionKey.forceUpdateVersion.rawValue].stringValue
    //      let currentVersion = Constants.appVersion
    //
    //      let currentComponents = currentVersion.split(separator: ".").map { Int($0) ?? 0 }
    //
    //      // 강제 업데이트 확인
    //      let forceComponents = forceVersion.split(separator: ".").map { Int($0) ?? 0 }
    //
    //      for index in 0..<max(currentComponents.count, forceComponents.count) {
    //        let current = index < currentComponents.count ? currentComponents[index] : 0
    //        let new = index < forceComponents.count ? forceComponents[index] : 0
    //
    //        if current < new {
    //          // 강제 업데이트 필요
    //          completion(.forceUpdate, forceVersion)
    //          return
    //        }
    //      }
    //      completion(.none, forceVersion)
    //    }
  }
}

extension DependencyValues {
  public var appUpdateClient: AppUpdateClient {
    get { self[AppUpdateClient.self] }
    set { self[AppUpdateClient.self] = newValue }
  }
}
