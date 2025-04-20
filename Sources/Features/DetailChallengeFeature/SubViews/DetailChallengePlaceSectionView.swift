//
//  DetailChallengePlaceSectionView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import SwiftUI
import Common
import DesignSystem

struct DetailChallengePlaceSectionView: View {
  let challenge: Challenge
  
  var body: some View {
    // 스탬프 미션 장소
    VStack(alignment: .leading, spacing: 0) {
      // 1. 제목
      Text(String(sLocalization: .detailchallengePlaceTitle))
        .font(.appTitle3)
        .foregroundColor(Colors.gray900.swiftUIColor)
      
      // 2. 설명
      Text(String(sLocalization: .detailchallengePlaceDes))
        .font(.captionL)
        .foregroundColor(Colors.gray400.swiftUIColor)
        .padding(.top, 2)
      
      // 장소 리스트
      VStack(spacing: 16) {
        ForEach(challenge.places) { place in
          ChallengePlaceListItemView(place: place, onLikeTapped: { })
        }
      }
      .padding(.top, 4)
    }
    .padding(.horizontal, 20)
  }
}

#Preview {
  DetailChallengePlaceSectionView(challenge: mockChallenges[0])
}
