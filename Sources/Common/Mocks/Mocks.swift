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
  public var comments: [Comment] = mockComments
  public var commentCount: Int {
    return comments.count
  }
  
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

public struct Comment: Equatable, Identifiable {
  public let id: UUID = .init()
  public let userId: UUID
  public let userNickname: String
  public let userState: String
  public let isCompleteUser: Bool
  public let createdAt: String
  public let content: String
  
  public var isMine: Bool {
    return self.userId == myId
  }
}

public let isLogined = true
public let myId = UUID(uuidString: "00000000-0000-0000-0000-000000000001")
public let mockComments: [Comment] = [
  Comment(
    userId: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
    userNickname: "방랑하는 배낭여행자",
    userState: "서울 강남구",
    isCompleteUser: true,
    createdAt: "2025.04.04 11:02",
    content: "코엑스 너무 예뻐요! 사진 맛집이네요 :) 코엑스 너무 예뻐요! 사진 맛집이네요 :) 코엑스 너무 예뻐요! 사진 맛집이네요 :) 코엑스 너무 예뻐요! 사진 맛집이네요 :) 코엑스 너무 예뻐요! 사진 맛집이네요 :) 코엑스 너무 예뻐요! 사진 맛집이네요 :) 코엑스 너무 예뻐요! 사진 맛집이네요 :) 코엑스 너무 예뻐요! 사진 맛집이네요 :) 코엑스 너무 예뻐요! 사진 맛집이네요 :) v "
  ),
  Comment(
    userId: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
    userNickname: "한옥러버",
    userState: "서울 종로구",
    isCompleteUser: false,
    createdAt: "2025.04.04 11:02",
    content: "북촌은 언제 가도 좋네요~"
  ),
  Comment(
    userId: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
    userNickname: "서울첫여행",
    userState: "서울 중구",
    isCompleteUser: true,
    createdAt: "2025.04.04 11:02",
    content: "스탬프 찍으려고 왔는데 진짜 재미있어요!!"
  )
]

public let mockPlace1: Place =  Place(
  name: "경복궁",
  description: "조선의 정궁으로 웅장한 건축미를 자랑하는 대표 명소.",
  address: "서울 종로구 사직로 161",
  openingHours: "09:00~18:00 (화요일 휴무)",
  website: "https://www.royalpalace.go.kr",
  phone: "02-3700-3900",
  transportation: "3호선 경복궁역 5번 출구, 도보 5분",
  isCompleted: true
)
public let mockPlace2: Place =  Place(
  name: "인사동 거리",
  description: "전통과 현대가 어우러진 예술 거리, 기념품 쇼핑 최적지.",
  address: "서울 종로구 인사동길",
  openingHours: "상점마다 다름 (대부분 10:00~20:00)",
  website: "https://korean.visitseoul.net",
  phone: "02-1330",
  transportation: "3호선 안국역 6번 출구, 도보 3분",
  likeCount: 0,
  participantCount: 0
)
public let mockPlace3: Place =  Place(
  name: "북촌한옥마을",
  description: "서울 도심 속 전통 한옥 주거지, 인생 사진 명소!",
  address: "서울 종로구 계동길 37",
  openingHours: "상시 개방 (거주지이므로 예의 준수)",
  website: "https://korean.visitseoul.net",
  phone: "02-3707-8388",
  transportation: "3호선 안국역 2번 출구, 도보 10분"
)
public let mockChallenges: [Challenge] = [
  Challenge(
    theme: "🏯 테마테마/테마테마",
    name: "🏯 조선의 수도, 한양을 걷다 🏯 조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지 경복궁부터 인사동까지 경복궁부터 인사동까지 경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.\n서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.\n서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [mockPlace1, mockPlace2, mockPlace3, mockPlace1, mockPlace2],
    comments: mockComments + mockComments + mockComments + mockComments + mockComments,
    isLike: true
  ),
  Challenge(
    theme: "역사 속 서울 걷기",
    name: "조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [mockPlace1, mockPlace2, mockPlace3, mockPlace1],
    comments: [],
    isParticipating: false
  ),
  Challenge(
    theme: "역사 속 서울 걷기",
    name: "조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [mockPlace1, mockPlace2, mockPlace3]
  ),
  Challenge(
    theme: "역사 속 서울 걷기",
    name: "조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [mockPlace1, mockPlace2],
    comments: [],
    isParticipating: false
  ),
  Challenge(
    theme: "역사 속 서울 걷기",
    name: "조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [mockPlace1]
  ),
  Challenge(
    theme: "역사 속 서울 걷기",
    name: "조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [mockPlace1, mockPlace2, mockPlace3, mockPlace1]
  ),
  Challenge(
    theme: "역사 속 서울 걷기",
    name: "조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [mockPlace1, mockPlace2, mockPlace3]
  ),
  Challenge(
    theme: "역사 속 서울 걷기",
    name: "조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [mockPlace1, mockPlace2, mockPlace3, mockPlace1]
  ),
  Challenge(
    theme: "역사 속 서울 걷기",
    name: "조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [mockPlace1, mockPlace2, mockPlace3]
  )
]
