//
//  ProgressBar.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/19/25.
//

import SwiftUI
import Common

public struct ProgressBar: View {  
  let progressType: ProgressType
  let total: Int
  let current: Int // 0-based index

  public init(progressType: ProgressType, total: Int, current: Int) {
    self.progressType = progressType
    self.total = total
    self.current = current
  }
  
  public var body: some View {
    GeometryReader { geo in
      HStack(spacing: 4) {
        let numberWidth: CGFloat = 24 // 숫자 영역 고정 너비
        let availableWidth = geo.size.width - progressType.rightPadding - numberWidth - CGFloat(total - 1) * 5
        let barWidth = availableWidth / CGFloat(total)
        
        // 바들
        HStack(spacing: 4) {
          ForEach(0..<total, id: \.self) { index in
            Rectangle()
              .fill(index < current ? Colors.blue400.swiftUIColor : Colors.gray100.swiftUIColor)
              .frame(width: barWidth, height: progressType.height)
              .cornerRadius(4)
          }
        }
        
        Text("\(current)/\(total)")
          .font(.captionM)
          .foregroundStyle(Colors.gray500.swiftUIColor)
          .frame(width: numberWidth, alignment: .trailing)

        Spacer()
      }
    }
    .frame(height: 14) // 바 높이 + 여백
  }
}

// MARK: Preview

#Preview {
  ProgressBar(progressType: .detailChallenge, total: 3, current: 2)
}

// MARK: - Helper

public enum ProgressType {
  case myChallenge
  case detailChallenge
  
  var rightPadding: CGFloat {
    switch self {
    case .myChallenge: return 36
    case .detailChallenge: return 0
    }
  }

  var height: CGFloat {
    switch self {
    case .myChallenge: return 5
    case .detailChallenge: return 8
    }
  }
}
