//
//  HomeMissingSection.swift
//  Features
//
//  Created by suni on 4/29/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import Models

struct HomeMissingSection: View {
  var challenges: [Challenge]
  var onTapped: (Int) -> Void
  var onStartTapped: (Int) -> Void
  
  var body: some View {
    let screenWidth = UIScreen.main.bounds.width
    let cardWidth = screenWidth * (160.0 / 375.0)
    let gradientHeight = cardWidth * 0.57
    
    ZStack(alignment: .topTrailing) {
      VStack(spacing: 0) {
        Rectangle()
          .fill(Color.hex(0x47ABF1))
          .frame(height: 152)
        
        Rectangle()
          .fill(LinearGradient.skyFadeTopToBottom)
          .frame(height: gradientHeight)
      }
      
      HStack {
        Spacer()
        Assets.Images.homeMissing.swiftUIImage
          .resizable()
          .scaledToFit()
          .frame(width: 139, height: 139)
          .padding(.top, 8)
          .padding(.trailing, 2)
          .rotationEffect(.degrees(12))
      }
      
      VStack(alignment: .leading, spacing: 0) {
        Text("🏃‍ 놓치고 있는 챌린지")
          .font(.appTitle2)
          .foregroundStyle(Colors.appWhite.swiftUIColor)
          .padding(.horizontal, 20)
          .padding(.top, 72)
        
        Text("지금 참여 중인 챌린지, 계속 이어가볼까요?")
          .font(.captionL)
          .foregroundStyle(Colors.gray25.swiftUIColor)
          .padding(.top, 4)
          .padding(.horizontal, 20)
        
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 8) {
            ForEach(challenges) { challenge in
              HomeMissingChallengeItemView(
                challenge: challenge,
                cardWidth: cardWidth,
                onStartTapped: {
                
              })
            } // ForEach
          }
          .padding(.horizontal, 20)
        }
        .padding(.top, 36)
      }
    }
    .background(.clear)
  }
}

extension LinearGradient {
  static let skyFadeTopToBottom = LinearGradient(
    gradient: Gradient(stops: [
      .init(color: Color.hex(0x47ABF1), location: 0.0),
      .init(color: Color.hex(0x67C1FF).opacity(0), location: 1.0)
    ]),
    startPoint: .top,
    endPoint: .bottom
  )
}
