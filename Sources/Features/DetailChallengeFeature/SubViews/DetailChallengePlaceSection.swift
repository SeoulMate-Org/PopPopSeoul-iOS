//
//  DetailChallengePlaceSection.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import Models

struct DetailChallengePlaceSection: View {
  let challenge: Challenge
  let onAttractionTap: (Int) -> Void
  let onLikeTap: (Int) -> Void
  
  var body: some View {
    // 스탬프 미션 장소
    VStack(alignment: .leading, spacing: 0) {
      // 1. 제목
      Text(L10n.detailChallengeText_missionSpots)
        .font(.appTitle3)
        .foregroundColor(Colors.gray900.swiftUIColor)
      
      // 2. 설명
      Text(L10n.detailChallengeSubText_getStamp)
        .font(.captionL)
        .foregroundColor(Colors.gray400.swiftUIColor)
        .padding(.top, 2)
      
      // 장소 리스트
      VStack(spacing: 16) {
        ForEach(challenge.attractions) { place in
          ChallengePlaceListItem(place: place, onLikeTapped: {
            onLikeTap(place.id)
          })
          .onTapGesture {
            onAttractionTap(place.id)
          }
        }
      }
      .padding(.top, 4)
    }
    .padding(.horizontal, 20)
  }
}
