//
//  DetailChallengeStampSection.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import SwiftUI
import Common
import DesignSystem

struct DetailChallengeStampSection: View {
  let challenge: Challenge
  
  var body: some View {
    
    // 스탬프 정보
    VStack(alignment: .leading, spacing: 0) {
      // 1. 제목
      Text(String(sLocalization: .detailchallengeStampTitle))
        .font(.appTitle3)
        .foregroundColor(Colors.gray900.swiftUIColor)
      
      // 2. 설명
      Text(String(sLocalization: .detailchallengeStampDes))
        .font(.captionL)
        .foregroundColor(Colors.gray400.swiftUIColor)
        .padding(.top, 2)
      
      // 3. 회색 배경 박스
      VStack(spacing: 0) {
        ProgressBar(progressType: .detailChallenge, total: challenge.places.count, current: challenge.completeCount)
          .padding(.horizontal, 20)
          .padding(.vertical, 17)
        Divider()
        ChallengeStampView(items: challenge.places)
          .padding(.vertical, 16)
      }
      .background(Colors.gray25.swiftUIColor)
      .cornerRadius(20)
      .padding(.top, 16)
    }
    .padding(.horizontal, 20)
  }
}

#Preview {
  DetailChallengeStampSection(challenge: mockChallenges[0])
}
