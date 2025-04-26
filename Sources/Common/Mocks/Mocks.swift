//
//  Mocks.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/19/25.
//

import Foundation

public struct Challenge: Equatable, Identifiable {
  public let id: UUID = .init()
  public let theme: String
  public let imageURL: String = "http://sohohaneulbit.cafe24.com/files/attach/images/357/358/b6f2a6a51114cd78ae4d64840f0ccb46.jpg"
  public let name: String
  public let subtitle: String
  public let description: String
  public let likeCount: Int = Int.random(in: 0..<20)
  public let participantCount: Int = Int.random(in: 0..<20)
  public let places: [Place]
  public let mainLocal: String = "한남동/이태원"
  public var commentCount: Int
  
  public var isParticipating: Bool = true
  
  public var completeCount: Int {
    return Int.random(in: 0..<places.count)
  }
  
  public var isLike: Bool = false
}

public struct Place: Equatable, Identifiable {
  public let id: UUID = .init()
  public let imageURL: String = "http://sohohaneulbit.cafe24.com/files/attach/images/357/358/b6f2a6a51114cd78ae4d64840f0ccb46.jpg"
  public let name: String
  public let description: String
  public let address: String
  public let openingHours: String
  public let website: String
  public let phone: String
  public let transportation: String
  public var isCompleted = false
  public var isLike = false
  public var likeCount: Int = Int.random(in: 0..<20)
  public var participantCount: Int = Int.random(in: 0..<20)
}

public let isLogined = true
public let myId = UUID(uuidString: "00000000-0000-0000-0000-000000000001")
