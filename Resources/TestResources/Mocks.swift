//
//  Mocks.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/19/25.
//

import Foundation

public struct Challenge: Equatable, Identifiable {
  public let id: UUID = .init()
  let theme: String
  let imageURL: String
  let name: String
  let subtitle: String
  let description: String
  let likeCount: Int = 12
  let commentCount: Int = 3
  let places: [Place]
}

public struct Place: Equatable, Identifiable {
  public let id: UUID = .init()
  let imageURL: String
  let name: String
  let description: String
  let address: String
  let openingHours: String
  let website: String
  let phone: String
  let transportation: String
}

public let mockChallenges: [Challenge] = [
  Challenge(
    theme: "역사 속 서울 걷기",
    imageURL: "https://example.com/challenge1.jpg",
    name: "조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [
      Place(
        imageURL: "https://example.com/gyeongbokgung.jpg",
        name: "경복궁",
        description: "조선의 정궁으로 웅장한 건축미를 자랑하는 대표 명소.",
        address: "서울 종로구 사직로 161",
        openingHours: "09:00~18:00 (화요일 휴무)",
        website: "https://www.royalpalace.go.kr",
        phone: "02-3700-3900",
        transportation: "3호선 경복궁역 5번 출구, 도보 5분"
      ),
      Place(
        imageURL: "https://example.com/insadong.jpg",
        name: "인사동 거리",
        description: "전통과 현대가 어우러진 예술 거리, 기념품 쇼핑 최적지.",
        address: "서울 종로구 인사동길",
        openingHours: "상점마다 다름 (대부분 10:00~20:00)",
        website: "https://korean.visitseoul.net",
        phone: "02-1330",
        transportation: "3호선 안국역 6번 출구, 도보 3분"
      ),
      Place(
        imageURL: "https://example.com/bukchon.jpg",
        name: "북촌한옥마을",
        description: "서울 도심 속 전통 한옥 주거지, 인생 사진 명소!",
        address: "서울 종로구 계동길 37",
        openingHours: "상시 개방 (거주지이므로 예의 준수)",
        website: "https://korean.visitseoul.net",
        phone: "02-3707-8388",
        transportation: "3호선 안국역 2번 출구, 도보 10분"
      )
    ]
  ),
  Challenge(
    theme: "역사 속 서울 걷기",
    imageURL: "https://example.com/challenge1.jpg",
    name: "조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [
      Place(
        imageURL: "https://example.com/gyeongbokgung.jpg",
        name: "경복궁",
        description: "조선의 정궁으로 웅장한 건축미를 자랑하는 대표 명소.",
        address: "서울 종로구 사직로 161",
        openingHours: "09:00~18:00 (화요일 휴무)",
        website: "https://www.royalpalace.go.kr",
        phone: "02-3700-3900",
        transportation: "3호선 경복궁역 5번 출구, 도보 5분"
      ),
      Place(
        imageURL: "https://example.com/insadong.jpg",
        name: "인사동 거리",
        description: "전통과 현대가 어우러진 예술 거리, 기념품 쇼핑 최적지.",
        address: "서울 종로구 인사동길",
        openingHours: "상점마다 다름 (대부분 10:00~20:00)",
        website: "https://korean.visitseoul.net",
        phone: "02-1330",
        transportation: "3호선 안국역 6번 출구, 도보 3분"
      ),
      Place(
        imageURL: "https://example.com/bukchon.jpg",
        name: "북촌한옥마을",
        description: "서울 도심 속 전통 한옥 주거지, 인생 사진 명소!",
        address: "서울 종로구 계동길 37",
        openingHours: "상시 개방 (거주지이므로 예의 준수)",
        website: "https://korean.visitseoul.net",
        phone: "02-3707-8388",
        transportation: "3호선 안국역 2번 출구, 도보 10분"
      )
    ]
  ),
  Challenge(
    theme: "역사 속 서울 걷기",
    imageURL: "https://example.com/challenge1.jpg",
    name: "조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [
      Place(
        imageURL: "https://example.com/gyeongbokgung.jpg",
        name: "경복궁",
        description: "조선의 정궁으로 웅장한 건축미를 자랑하는 대표 명소.",
        address: "서울 종로구 사직로 161",
        openingHours: "09:00~18:00 (화요일 휴무)",
        website: "https://www.royalpalace.go.kr",
        phone: "02-3700-3900",
        transportation: "3호선 경복궁역 5번 출구, 도보 5분"
      ),
      Place(
        imageURL: "https://example.com/insadong.jpg",
        name: "인사동 거리",
        description: "전통과 현대가 어우러진 예술 거리, 기념품 쇼핑 최적지.",
        address: "서울 종로구 인사동길",
        openingHours: "상점마다 다름 (대부분 10:00~20:00)",
        website: "https://korean.visitseoul.net",
        phone: "02-1330",
        transportation: "3호선 안국역 6번 출구, 도보 3분"
      ),
      Place(
        imageURL: "https://example.com/bukchon.jpg",
        name: "북촌한옥마을",
        description: "서울 도심 속 전통 한옥 주거지, 인생 사진 명소!",
        address: "서울 종로구 계동길 37",
        openingHours: "상시 개방 (거주지이므로 예의 준수)",
        website: "https://korean.visitseoul.net",
        phone: "02-3707-8388",
        transportation: "3호선 안국역 2번 출구, 도보 10분"
      )
    ]
  ),
  Challenge(
    theme: "역사 속 서울 걷기",
    imageURL: "https://example.com/challenge1.jpg",
    name: "조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [
      Place(
        imageURL: "https://example.com/gyeongbokgung.jpg",
        name: "경복궁",
        description: "조선의 정궁으로 웅장한 건축미를 자랑하는 대표 명소.",
        address: "서울 종로구 사직로 161",
        openingHours: "09:00~18:00 (화요일 휴무)",
        website: "https://www.royalpalace.go.kr",
        phone: "02-3700-3900",
        transportation: "3호선 경복궁역 5번 출구, 도보 5분"
      ),
      Place(
        imageURL: "https://example.com/insadong.jpg",
        name: "인사동 거리",
        description: "전통과 현대가 어우러진 예술 거리, 기념품 쇼핑 최적지.",
        address: "서울 종로구 인사동길",
        openingHours: "상점마다 다름 (대부분 10:00~20:00)",
        website: "https://korean.visitseoul.net",
        phone: "02-1330",
        transportation: "3호선 안국역 6번 출구, 도보 3분"
      ),
      Place(
        imageURL: "https://example.com/bukchon.jpg",
        name: "북촌한옥마을",
        description: "서울 도심 속 전통 한옥 주거지, 인생 사진 명소!",
        address: "서울 종로구 계동길 37",
        openingHours: "상시 개방 (거주지이므로 예의 준수)",
        website: "https://korean.visitseoul.net",
        phone: "02-3707-8388",
        transportation: "3호선 안국역 2번 출구, 도보 10분"
      )
    ]
  ),
  Challenge(
    theme: "역사 속 서울 걷기",
    imageURL: "https://example.com/challenge1.jpg",
    name: "조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [
      Place(
        imageURL: "https://example.com/gyeongbokgung.jpg",
        name: "경복궁",
        description: "조선의 정궁으로 웅장한 건축미를 자랑하는 대표 명소.",
        address: "서울 종로구 사직로 161",
        openingHours: "09:00~18:00 (화요일 휴무)",
        website: "https://www.royalpalace.go.kr",
        phone: "02-3700-3900",
        transportation: "3호선 경복궁역 5번 출구, 도보 5분"
      ),
      Place(
        imageURL: "https://example.com/insadong.jpg",
        name: "인사동 거리",
        description: "전통과 현대가 어우러진 예술 거리, 기념품 쇼핑 최적지.",
        address: "서울 종로구 인사동길",
        openingHours: "상점마다 다름 (대부분 10:00~20:00)",
        website: "https://korean.visitseoul.net",
        phone: "02-1330",
        transportation: "3호선 안국역 6번 출구, 도보 3분"
      ),
      Place(
        imageURL: "https://example.com/bukchon.jpg",
        name: "북촌한옥마을",
        description: "서울 도심 속 전통 한옥 주거지, 인생 사진 명소!",
        address: "서울 종로구 계동길 37",
        openingHours: "상시 개방 (거주지이므로 예의 준수)",
        website: "https://korean.visitseoul.net",
        phone: "02-3707-8388",
        transportation: "3호선 안국역 2번 출구, 도보 10분"
      )
    ]
  ),
  Challenge(
    theme: "역사 속 서울 걷기",
    imageURL: "https://example.com/challenge1.jpg",
    name: "조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [
      Place(
        imageURL: "https://example.com/gyeongbokgung.jpg",
        name: "경복궁",
        description: "조선의 정궁으로 웅장한 건축미를 자랑하는 대표 명소.",
        address: "서울 종로구 사직로 161",
        openingHours: "09:00~18:00 (화요일 휴무)",
        website: "https://www.royalpalace.go.kr",
        phone: "02-3700-3900",
        transportation: "3호선 경복궁역 5번 출구, 도보 5분"
      ),
      Place(
        imageURL: "https://example.com/insadong.jpg",
        name: "인사동 거리",
        description: "전통과 현대가 어우러진 예술 거리, 기념품 쇼핑 최적지.",
        address: "서울 종로구 인사동길",
        openingHours: "상점마다 다름 (대부분 10:00~20:00)",
        website: "https://korean.visitseoul.net",
        phone: "02-1330",
        transportation: "3호선 안국역 6번 출구, 도보 3분"
      ),
      Place(
        imageURL: "https://example.com/bukchon.jpg",
        name: "북촌한옥마을",
        description: "서울 도심 속 전통 한옥 주거지, 인생 사진 명소!",
        address: "서울 종로구 계동길 37",
        openingHours: "상시 개방 (거주지이므로 예의 준수)",
        website: "https://korean.visitseoul.net",
        phone: "02-3707-8388",
        transportation: "3호선 안국역 2번 출구, 도보 10분"
      )
    ]
  ),
  Challenge(
    theme: "역사 속 서울 걷기",
    imageURL: "https://example.com/challenge1.jpg",
    name: "조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [
      Place(
        imageURL: "https://example.com/gyeongbokgung.jpg",
        name: "경복궁",
        description: "조선의 정궁으로 웅장한 건축미를 자랑하는 대표 명소.",
        address: "서울 종로구 사직로 161",
        openingHours: "09:00~18:00 (화요일 휴무)",
        website: "https://www.royalpalace.go.kr",
        phone: "02-3700-3900",
        transportation: "3호선 경복궁역 5번 출구, 도보 5분"
      ),
      Place(
        imageURL: "https://example.com/insadong.jpg",
        name: "인사동 거리",
        description: "전통과 현대가 어우러진 예술 거리, 기념품 쇼핑 최적지.",
        address: "서울 종로구 인사동길",
        openingHours: "상점마다 다름 (대부분 10:00~20:00)",
        website: "https://korean.visitseoul.net",
        phone: "02-1330",
        transportation: "3호선 안국역 6번 출구, 도보 3분"
      ),
      Place(
        imageURL: "https://example.com/bukchon.jpg",
        name: "북촌한옥마을",
        description: "서울 도심 속 전통 한옥 주거지, 인생 사진 명소!",
        address: "서울 종로구 계동길 37",
        openingHours: "상시 개방 (거주지이므로 예의 준수)",
        website: "https://korean.visitseoul.net",
        phone: "02-3707-8388",
        transportation: "3호선 안국역 2번 출구, 도보 10분"
      )
    ]
  ),
  Challenge(
    theme: "역사 속 서울 걷기",
    imageURL: "https://example.com/challenge1.jpg",
    name: "조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [
      Place(
        imageURL: "https://example.com/gyeongbokgung.jpg",
        name: "경복궁",
        description: "조선의 정궁으로 웅장한 건축미를 자랑하는 대표 명소.",
        address: "서울 종로구 사직로 161",
        openingHours: "09:00~18:00 (화요일 휴무)",
        website: "https://www.royalpalace.go.kr",
        phone: "02-3700-3900",
        transportation: "3호선 경복궁역 5번 출구, 도보 5분"
      ),
      Place(
        imageURL: "https://example.com/insadong.jpg",
        name: "인사동 거리",
        description: "전통과 현대가 어우러진 예술 거리, 기념품 쇼핑 최적지.",
        address: "서울 종로구 인사동길",
        openingHours: "상점마다 다름 (대부분 10:00~20:00)",
        website: "https://korean.visitseoul.net",
        phone: "02-1330",
        transportation: "3호선 안국역 6번 출구, 도보 3분"
      ),
      Place(
        imageURL: "https://example.com/bukchon.jpg",
        name: "북촌한옥마을",
        description: "서울 도심 속 전통 한옥 주거지, 인생 사진 명소!",
        address: "서울 종로구 계동길 37",
        openingHours: "상시 개방 (거주지이므로 예의 준수)",
        website: "https://korean.visitseoul.net",
        phone: "02-3707-8388",
        transportation: "3호선 안국역 2번 출구, 도보 10분"
      )
    ]
  ),
  Challenge(
    theme: "역사 속 서울 걷기",
    imageURL: "https://example.com/challenge1.jpg",
    name: "조선의 수도, 한양을 걷다",
    subtitle: "경복궁부터 인사동까지",
    description: "서울의 역사 중심지인 종로 일대를 걸으며 조선시대의 흔적을 느껴보세요.",
    places: [
      Place(
        imageURL: "https://example.com/gyeongbokgung.jpg",
        name: "경복궁",
        description: "조선의 정궁으로 웅장한 건축미를 자랑하는 대표 명소.",
        address: "서울 종로구 사직로 161",
        openingHours: "09:00~18:00 (화요일 휴무)",
        website: "https://www.royalpalace.go.kr",
        phone: "02-3700-3900",
        transportation: "3호선 경복궁역 5번 출구, 도보 5분"
      ),
      Place(
        imageURL: "https://example.com/insadong.jpg",
        name: "인사동 거리",
        description: "전통과 현대가 어우러진 예술 거리, 기념품 쇼핑 최적지.",
        address: "서울 종로구 인사동길",
        openingHours: "상점마다 다름 (대부분 10:00~20:00)",
        website: "https://korean.visitseoul.net",
        phone: "02-1330",
        transportation: "3호선 안국역 6번 출구, 도보 3분"
      ),
      Place(
        imageURL: "https://example.com/bukchon.jpg",
        name: "북촌한옥마을",
        description: "서울 도심 속 전통 한옥 주거지, 인생 사진 명소!",
        address: "서울 종로구 계동길 37",
        openingHours: "상시 개방 (거주지이므로 예의 준수)",
        website: "https://korean.visitseoul.net",
        phone: "02-3707-8388",
        transportation: "3호선 안국역 2번 출구, 도보 10분"
      )
    ]
  ),
  
]
