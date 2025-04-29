//
//  HomeSimilarSection.swift
//  Features
//
//  Created by suni on 4/29/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import SharedTypes
import Models

struct HomeSimilarSection: View {
  let lastAttractionName: String
  let challenges: [MyChallenge]
  var onTapped: (Int) -> Void
  
  var body: some View {
    let screenWidth = UIScreen.main.bounds.width
    let cardWidth = screenWidth * (160.0 / 375.0)
    
    VStack(alignment: .leading, spacing: 0) {
      // MARK: - 헤더 타이틀
      Text("😎 ‘{\(lastAttractionName)}’과 비슷한 챌린지")
        .font(.appTitle2)
        .foregroundStyle(Colors.gray900.swiftUIColor)
        .padding(.horizontal, 20)
      
      Text("최근에 스탬프한 장소가 포함된 챌린지예요")
        .font(.captionL)
        .foregroundStyle(Colors.gray600.swiftUIColor)
        .padding(.top, 4)
        .padding(.horizontal, 20)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 8) {
          ForEach(challenges) { challenge in
            HomeChallengeItemView(challenge: challenge, cardWidth: cardWidth)
              .onTapGesture {
                onTapped(challenge.id)
              }
          } // ForEach
        }
        .padding(.horizontal, 20)
      }
      .padding(.top, 16)
    }
    .background(.clear)
  }
}
