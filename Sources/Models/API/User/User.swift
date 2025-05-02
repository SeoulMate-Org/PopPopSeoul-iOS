//
//  User.swift
//  Models
//
//  Created by suni on 5/2/25.
//

import Foundation
import SharedTypes

public struct User: Hashable {
  public let id: Int
  public let nickname: String
  public let loginType: String
  public var appLoginType: AppLoginType {
    return AppLoginType(rawValue: loginType) ?? .none
  }
  public let badgeCount: Int
  public let likeCount: Int
  public let commentCount: Int
  
  public init(id: Int, nickname: String, loginType: String, badgeCount: Int, likeCount: Int, commentCount: Int) {
    self.id = id
    self.nickname = nickname
    self.loginType = loginType
    self.badgeCount = badgeCount
    self.likeCount = likeCount
    self.commentCount = commentCount
  }
}
