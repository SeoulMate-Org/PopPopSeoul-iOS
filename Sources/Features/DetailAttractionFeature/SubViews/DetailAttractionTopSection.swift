//
//  DetailAttractionTopSection.swift
//  Features
//
//  Created by suni on 4/30/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import Models
import Kingfisher

struct DetailAttractionTopSection: View {
  let attraction: Attraction
  let onLikeTapped: () -> Void
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      
      ZStack(alignment: .bottomTrailing) {
        // 이미지
        KFImage( URL(string: attraction.imageUrl))
          .placeholder {
            Assets.Images.placeholderImage.swiftUIImage
              .resizable()
              .scaledToFill()
          }.retry(maxCount: 2, interval: .seconds(5))
          .resizable()
          .scaledToFill()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 234 / 375)
          .clipped()
        
        Button(action: {
          onLikeTapped()
        }) {
          let image = attraction.isLiked ? Assets.Icons.heartFill.swiftUIImage : Assets.Icons.heartLine.swiftUIImage
          image
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundColor(attraction.isLiked ? Colors.red500.swiftUIColor : Colors.gray700.swiftUIColor)
        }
        .frame(width: 40, height: 40)
        .background(Colors.gray25.swiftUIColor)
        .cornerRadius(12, corners: .allCorners)
        .padding(.bottom, 12)
        .padding(.trailing, 12)
      }
      .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 234 / 375)
      
      // 챌린지 정보
      VStack(alignment: .leading, spacing: 0) {
        Text(attraction.name)
          .font(.appTitle3)
          .foregroundColor(Color.hex(0x2B2B2B))
          .fixedSize(horizontal: false, vertical: true)
          .padding(.top, 4)
        
        // 6. 설명
        ExpandableText(text: attraction.description)
          .fixedSize(horizontal: false, vertical: true)
          .padding(.top, 8)
      }
      .padding(.horizontal, 20)
      .padding(.top, 16)
    }
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
