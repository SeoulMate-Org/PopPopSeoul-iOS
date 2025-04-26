//
//  Pageable.swift
//  Models
//
//  Created by suni on 4/27/25.
//

import Foundation

public struct Pageable: Hashable, Equatable {
  public let pageNumber: Int
  public let pageSize: Int
  public let sort: [Sort]
  public let offset: Int
  public let paged: Bool
  public let unpaged: Bool
  
  public init(
    pageNumber: Int,
    pageSize: Int,
    sort: [Sort],
    offset: Int,
    paged: Bool,
    unpaged: Bool
  ) {
    self.pageNumber = pageNumber
    self.pageSize = pageSize
    self.sort = sort
    self.offset = offset
    self.paged = paged
    self.unpaged = unpaged
  }
}

public struct Sort: Hashable, Equatable {
  public init() { }
  // 정렬 조건이 비어있어서 구조가 명확하지 않음 (ex: {"property": "createdAt", "direction": "ASC"})
  // 기본적으로 빈 배열([])로 오고 있어서 임시로 비워둠
}

extension Pageable: Codable {
  private enum CodingKeys: String, CodingKey {
    case pageNumber
    case pageSize
    case sort
    case offset
    case paged
    case unpaged
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    pageNumber = try container.decodeIfPresent(Int.self, forKey: .pageNumber) ?? 0
    pageSize = try container.decodeIfPresent(Int.self, forKey: .pageSize) ?? 0
    sort = try container.decodeIfPresent([Sort].self, forKey: .sort) ?? []
    offset = try container.decodeIfPresent(Int.self, forKey: .offset) ?? 0
    paged = try container.decodeIfPresent(Bool.self, forKey: .paged) ?? false
    unpaged = try container.decodeIfPresent(Bool.self, forKey: .unpaged) ?? false
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encodeIfPresent(pageNumber, forKey: .pageNumber)
    try container.encodeIfPresent(pageSize, forKey: .pageSize)
    try container.encodeIfPresent(sort, forKey: .sort)
    try container.encodeIfPresent(offset, forKey: .offset)
    try container.encodeIfPresent(paged, forKey: .paged)
    try container.encodeIfPresent(unpaged, forKey: .unpaged)
  }
  
  // 기본 생성자 필요 (CommentListResponse 초기화 때)
  public init() {
    self.pageNumber = 0
    self.pageSize = 0
    self.sort = []
    self.offset = 0
    self.paged = false
    self.unpaged = false
  }
}

extension Sort: Codable {
  // 현재는 API 응답이 빈 배열이라 내부 필드 없음
  public init(from decoder: Decoder) throws {}
  
  public func encode(to encoder: Encoder) throws {}
}
