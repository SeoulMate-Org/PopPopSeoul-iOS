//
//  HomeChallengeItemView.swift
//  Features
//
//  Created by suni on 4/28/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import Models
import Kingfisher

struct HomeChallengeItemView: View {
  let challenge: MyChallenge
  let cardWidth: CGFloat
  
  var body: some View {
    let cardHeight = cardWidth + 8.0 + 58.0
    
    VStack(alignment: .leading, spacing: 0) {
      ZStack(alignment: .topLeading) {
        KFImage( URL(string: challenge.imageUrl))
          .placeholder {
            Assets.Images.placeholderImage.swiftUIImage
              .resizable()
              .scaledToFill()
          }.retry(maxCount: 2, interval: .seconds(5))
          .resizable()
          .frame(maxWidth: cardWidth, maxHeight: cardWidth)
        
        HStack(spacing: 4) {
          Assets.Icons.route.swiftUIImage
            .resizable()
            .scaledToFit()
            .foregroundStyle(Colors.blue50.swiftUIColor)
            .frame(width: 16, height: 16) // 이미지가 너무 크게 나옴!!
            .padding(.vertical, 6)
            .padding(.leading, 6)
          
          Text(challenge.distance.formattedDistance)
            .font(.captionM)
            .foregroundColor(Colors.blue50.swiftUIColor)
            .padding(.vertical, 6)
            .padding(.trailing, 8)
        }
        .background(Colors.blue500.swiftUIColor)
        .frame(height: 28)
        .cornerRadius(10, corners: [.bottomRight])
      }
      .frame(maxWidth: cardWidth, maxHeight: cardWidth)
      .cornerRadius(16, corners: .allCorners)
      
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

#Preview {
  HomeChallengeItemView(challenge: mockMyChallenge, cardWidth: 160)
}
