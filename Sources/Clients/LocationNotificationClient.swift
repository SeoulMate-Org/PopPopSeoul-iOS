//
//  LocationNotificationClient.swift
//  Clients
//
//  Created by suni on 5/14/25.
//

import Foundation
import ComposableArchitecture
import CoreLocation
import UserNotifications
import Models

public struct NotificationClient {
  public var registerLocation: @Sendable (_ challenge: Challenge, _ attractions: [Attraction]) async -> Void
  public var removeAllLcoation: @Sendable (_ challengeId: Int, _ attractionIds: [Int]) -> Void
  public var removeLcoation: @Sendable (_ challengeId: Int, _ attractionId: Int) -> Void
  public var removeAll: @Sendable () -> Void
}

extension NotificationClient: DependencyKey {
  public static let liveValue: Self = {
    let center = UNUserNotificationCenter.current()

    return Self(
      registerLocation: { challenge, attractions in
        _ = try? await center.requestAuthorization(options: [.alert, .sound, .badge])

        for attraction in attractions.prefix(5) {
          guard let coordinate = attraction.coordinate else { continue }
          
          let region = CLCircularRegion(
            center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude),
            radius: 50,
            identifier: Self.identifier(challengeId: challenge.id, attractionId: attraction.id)
          )
          region.notifyOnEntry = true
          region.notifyOnExit = false

          let trigger = UNLocationNotificationTrigger(region: region, repeats: false)

          let content = UNMutableNotificationContent()
          // TODO: - 위치 알림 기획 반영
          content.title = "🧭 \(challenge.name) 지역 도착!"
          content.body = "지금 \"\(attraction.name)\" 스탬프를 찍고 도전을 기록해보세요"
          content.sound = .default

          let request = UNNotificationRequest(
            identifier: region.identifier,
            content: content,
            trigger: trigger
          )

          try? await center.add(request)
        }
      },
      removeAllLcoation: { challengeId, attractionIds in
        let identifiers = attractionIds.map {
          Self.identifier(challengeId: challengeId, attractionId: $0)
        }
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
      },
      removeLcoation: { challengeId, attractionId in
        let id = Self.identifier(challengeId: challengeId, attractionId: attractionId)
        center.removePendingNotificationRequests(withIdentifiers: [id])
      },
      removeAll: {
        center.removeAllPendingNotificationRequests()
      }
    )
  }()

  private static func identifier(challengeId: Int, attractionId: Int) -> String {
    "challenge_\(challengeId)_attraction_\(attractionId)"
  }
}

public extension DependencyValues {
  var notificationClient: NotificationClient {
    get { self[NotificationClient.self] }
    set { self[NotificationClient.self] = newValue }
  }
}
