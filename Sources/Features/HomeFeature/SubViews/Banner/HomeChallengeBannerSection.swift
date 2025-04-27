//
//  HomeChallengeBannerSection.swift
//  Clients
//
//  Created by suni on 4/23/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import Models

struct HomeChallengeBannerSection: View {
  var challenges: [MyChallenge]
  var onLikeTapped: (Int) -> Void
  
  var body: some View {
    let screenWidth = UIScreen.main.bounds.width
    let cardWidth = screenWidth * (300.0 / 375.0)
    let cardHeight = cardWidth * (280.0 / 300.0)
    let gradientHeight = screenWidth * (383.0 / 375.0)
    
    ZStack(alignment: .topTrailing) {
      
      Rectangle()
        .fill(LinearGradient.blueFadeTopToBottom)
        .frame(height: gradientHeight)
        .ignoresSafeArea()

      HStack {
        Spacer()
        Assets.Images.homeBanner.swiftUIImage
          .frame(width: 164, height: 164)
          .padding(.top, 12)
          .padding(.trailing, 16)
      }
      
      VStack(alignment: .leading, spacing: 16) {
        Text("⛳️ 지금 바로\n도전 가능한 챌린지!")
          .font(.appTitle1)
          .lineLimit(2)
          .lineSpacing(9)
          .foregroundColor(Colors.appWhite.swiftUIColor)
          .padding(.horizontal, 20)
          .padding(.top, 83)
        
        ScrollView(.horizontal) {
          HStack(spacing: 12) {
            ForEach(challenges) { challenge in
              HomeChallengeBannerItemView(
                challenge: challenge,
                onLikeTapped: {
                  onLikeTapped(challenge.id)
                },
                cardWidth: cardWidth,
                cardHeight: cardHeight
              )
            } // ForEach
          } // HStack
          .scrollTargetLayout()
          .frame(height: cardHeight)
          .padding(.horizontal, 20)
        } // Scroll View
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
      }
    }
  }
}

extension LinearGradient {
  static let blueFadeTopToBottom = LinearGradient(
    gradient: Gradient(stops: [
      .init(color: Colors.blue500.swiftUIColor, location: 0.0),
      .init(color: Colors.appWhite.swiftUIColor, location: 1.0)
    ]),
    startPoint: .top,
    endPoint: .bottom
  )
}
