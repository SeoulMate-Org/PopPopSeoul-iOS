//
//  HomeChallengeLocationSection.swift
//  Features
//
//  Created by suni on 4/28/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import SharedTypes
import Models

struct HomeChallengeLocationSection: View {
  let challenges: [MyChallenge]
  var onTapped: (Int) -> Void
  
  var body: some View {
    let screenWidth = UIScreen.main.bounds.width
    let cardWidth = screenWidth * (160.0 / 375.0)
    
    VStack(alignment: .leading, spacing: 0) {
      // MARK: - 헤더 타이틀
      Text("🏅 근처 챌린지, 놓치지 마세요!")
        .font(.appTitle2)
        .foregroundStyle(Colors.gray900.swiftUIColor)
        .padding(.horizontal, 20)
      
      Text("바로 근처에서 스탬프를 찍을 수 있어요")
        .font(.captionL)
        .foregroundStyle(Colors.gray600.swiftUIColor)
        .padding(.top, 4)
        .padding(.horizontal, 20)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 8) {
          ForEach(challenges) { challenge in
            HomeChallengeLocationItemView(challenge: challenge, cardWidth: cardWidth)
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
