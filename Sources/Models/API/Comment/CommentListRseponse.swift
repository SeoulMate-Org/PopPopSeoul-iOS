//
//  CommentListRseponse.swift
//  Models
//
//  Created by suni on 4/27/25.
//

import Foundation

public struct CommentListResponse: Hashable, Equatable {
  public let content: [Comment]
  public let pageable: Pageable
  public let totalPages: Int
  public let totalElements: Int
  public let last: Bool
  public let size: Int
  public let number: Int
  public let sort: [Sort]
  public let numberOfElements: Int
  public let first: Bool
  public let empty: Bool
  
  public init(
    content: [Comment],
    pageable: Pageable,
    totalPages: Int,
    totalElements: Int,
    last: Bool,
    size: Int,
    number: Int,
    sort: [Sort],
    numberOfElements: Int,
    first: Bool,
    empty: Bool
  ) {
    self.content = content
    self.pageable = pageable
    self.totalPages = totalPages
    self.totalElements = totalElements
    self.last = last
    self.size = size
    self.number = number
    self.sort = sort
    self.numberOfElements = numberOfElements
    self.first = first
    self.empty = empty
  }
}

extension CommentListResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case content
        case pageable
        case totalPages
        case totalElements
        case last
        case size
        case number
        case sort
        case numberOfElements
        case first
        case empty
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        content = try container.decodeIfPresent([Comment].self, forKey: .content) ?? []
        pageable = try container.decodeIfPresent(Pageable.self, forKey: .pageable) ?? Pageable()
        totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages) ?? 0
        totalElements = try container.decodeIfPresent(Int.self, forKey: .totalElements) ?? 0
        last = try container.decodeIfPresent(Bool.self, forKey: .last) ?? false
        size = try container.decodeIfPresent(Int.self, forKey: .size) ?? 0
        number = try container.decodeIfPresent(Int.self, forKey: .number) ?? 0
        sort = try container.decodeIfPresent([Sort].self, forKey: .sort) ?? []
        numberOfElements = try container.decodeIfPresent(Int.self, forKey: .numberOfElements) ?? 0
        first = try container.decodeIfPresent(Bool.self, forKey: .first) ?? false
        empty = try container.decodeIfPresent(Bool.self, forKey: .empty) ?? false
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(content, forKey: .content)
        try container.encodeIfPresent(pageable, forKey: .pageable)
        try container.encodeIfPresent(totalPages, forKey: .totalPages)
        try container.encodeIfPresent(totalElements, forKey: .totalElements)
        try container.encodeIfPresent(last, forKey: .last)
        try container.encodeIfPresent(size, forKey: .size)
        try container.encodeIfPresent(number, forKey: .number)
        try container.encodeIfPresent(sort, forKey: .sort)
        try container.encodeIfPresent(numberOfElements, forKey: .numberOfElements)
        try container.encodeIfPresent(first, forKey: .first)
        try container.encodeIfPresent(empty, forKey: .empty)
    }
}
