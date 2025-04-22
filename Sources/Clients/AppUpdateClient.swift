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
import FirebaseRemoteConfigSwift
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
  
  private static func checkForUpdate(completion: @escaping (_ update: AppUpdate, _ storeVersion: String?) -> Void) {
    
    let remoteConfig = RemoteConfig.remoteConfig()
    let settings = RemoteConfigSettings()
    settings.minimumFetchInterval = 0
    remoteConfig.configSettings = settings
    remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
    
    // Remote Config 값 가져오기
    print("Get remoteConfig \(remoteConfig)")
    // TODO: - Remote Config 연결
    completion(.none, nil)
    
    remoteConfig.fetch { status, error in
            
      if status == .success {
        remoteConfig.activate { _, error in
          if error != nil {
            // 실패
            completion(.none, nil)
          }
          
          // 값을 사용할 수 있습니다.
          let forceVersion = remoteConfig[AppVersionKey.forceUpdateVersion.rawValue].stringValue ?? "0.0.1"
          let currentVersion = Constants.appVersion
          
          let currentComponents = currentVersion.split(separator: ".").map { Int($0) ?? 0 }
          
          // 강제 업데이트 확인
          let forceComponents = forceVersion.split(separator: ".").map { Int($0) ?? 0 }
          
          for index in 0..<max(currentComponents.count, forceComponents.count) {
            let current = index < currentComponents.count ? currentComponents[index] : 0
            let new = index < forceComponents.count ? forceComponents[index] : 0
            
            if current < new {
              // 강제 업데이트 필요
              completion(.forceUpdate, forceVersion)
              return
            }
          }
          
          completion(.none, forceVersion)
        }
      } else {
        // 실패
        completion(.none, nil)
      }
    }
  }
}

extension DependencyValues {
  public var appUpdateClient: AppUpdateClient {
    get { self[AppUpdateClient.self] }
    set { self[AppUpdateClient.self] = newValue }
  }
}
