//
//  Double++.swift
//  Common
//
//  Created by suni on 5/1/25.
//

import Foundation

public extension Double {
  /// 미터(m) 단위를 km로 변환해주는 함수
  /// - 1000m 이상이면 "x.xkm" 형식
  /// - 1000m 미만이면 "xxxm" 형식
  var formattedDistance: String {
    if self >= 1000 {
      let km = self / 1000.0
      return String(format: "%.1fkm", km)
    } else {
      return "\(Int(self))m"
    }
  }
}
