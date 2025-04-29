//
//  HomeMissingChallengeItemView.swift
//  Features
//
//  Created by suni on 4/29/25.
//

import SwiftUI
import SharedTypes
import SharedAssets
import Models
import Common
import DesignSystem
import Kingfisher

struct HomeMissingChallengeItemView: View {
  let challenge: Challenge
  let cardWidth: CGFloat
  let onStartTapped: () -> Void
  
  var body: some View {
    let cardHeight = cardWidth + 48 + 58
    
    VStack(alignment: .leading, spacing: 0) {
      ZStack(alignment: .bottom) {
        KFImage( URL(string: challenge.imageUrl))
          .placeholder {
            Assets.Images.placeholderImage.swiftUIImage
              .resizable()
              .scaledToFill()
          }.retry(maxCount: 2, interval: .seconds(5))
          .resizable()
          .scaledToFill()
          .frame(width: cardWidth, height: cardWidth)
        
        ProgressBar(
          progressType: .missingChallenge,
          total: challenge.attractionCount,
          current: challenge.myStampCount
        )
        .frame(height: 14)
        .padding(.vertical, 8)
        .padding(.leading, 14)
      }
      .frame(maxWidth: cardWidth, maxHeight: cardWidth)
      .cornerRadius(16, corners: .allCorners)
            
      Button(action: {
        onStartTapped()
      }) {
        Text("챌린지 시작하기")
          .font(.buttonS)
          .foregroundColor(Colors.blue500.swiftUIColor)
          .padding(.vertical, 6)
      }
      .frame(width: cardWidth, height: 32)
      .background(Colors.appWhite.swiftUIColor)
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .stroke(Colors.blue200.swiftUIColor, lineWidth: 1.5)
      )
      .cornerRadius(10)
      .padding(.top, 8)
      
      Text(challenge.name)
        .lineLimit(2)
        .font(.bodyM)
        .foregroundColor(Color.hex(0x2B2B2B))
        .padding(.top, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      HStack(spacing: 10) {
        iconStat(image: Assets.Icons.heartFill.swiftUIImage, count: challenge.likes)
        iconStat(image: Assets.Icons.locationFill.swiftUIImage, count: challenge.attractionCount)
      }
      .padding(.top, 4)
    }
    .frame(width: cardWidth)
    .frame(minHeight: cardHeight, alignment: .top)
    .background(.clear)
  }
  
  private func iconStat(image: Image, count: Int) -> some View {
    HStack(spacing: 2) {
      image
        .resizable()
        .frame(width: 16, height: 16)
        .foregroundColor(Colors.gray200.swiftUIColor)
      Text("\(count)")
        .font(.captionL)
        .foregroundColor(Colors.gray300.swiftUIColor)
    }
  }
}
