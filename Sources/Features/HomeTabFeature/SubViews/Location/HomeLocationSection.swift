//
//  HomeLocationSection.swift
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

struct HomeLocationSection: View {
  let isDefault: Bool
  let challenges: [Challenge]
  var onTapped: (Int) -> Void
  
  var body: some View {
    let screenWidth = UIScreen.main.bounds.width
    let cardWidth = screenWidth * (160.0 / 375.0)
    
    VStack(alignment: .leading, spacing: 0) {
      // MARK: - 헤더 타이틀
      Text(L10n.homeBackGroundText_nearby)
        .font(.appTitle2)
        .foregroundStyle(Colors.gray900.swiftUIColor)
        .padding(.horizontal, 20)
      
      Text(isDefault ? L10n.homeBackGroundText_jonggak : L10n.homeBackGroundText_rightNearby)
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
