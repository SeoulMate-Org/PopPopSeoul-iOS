//
//  LikeAttractionItemView.swift
//  Features
//
//  Created by suni on 5/2/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import SharedTypes
import Models
import Kingfisher

struct LikeAttractionItemView: View {
  let attraction: Attraction
  let onLikeTapped: () -> Void
  
  var body: some View {
    HStack(alignment: .center, spacing: 8) {
      KFImage( URL(string: attraction.imageUrl))
        .placeholder {
          Assets.Images.placeholderImage.swiftUIImage
            .resizable()
            .scaledToFill()
        }.retry(maxCount: 2, interval: .seconds(5))
        .resizable()
        .scaledToFill()
        .frame(width: 76, height: 76)
        .clipShape(RoundedRectangle(cornerRadius: 16))
      
      VStack(alignment: .leading, spacing: 4) {
        
        Text(attraction.name)
          .font(.bodyM)
          .foregroundColor(Colors.gray900.swiftUIColor)
          .lineLimit(2)
        
        HStack(spacing: 10) {
          if attraction.likes > 0 {
            iconStat(image: Assets.Icons.heartFill.swiftUIImage, count: attraction.likes)
          }
          if attraction.stampCount > 0 {
            iconStat(image: Assets.Icons.profileFill.swiftUIImage, count: attraction.stampCount)
          }
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
            
      Button(action: {
        onLikeTapped()
      }) {
        Assets.Icons.heartFill.swiftUIImage
          .foregroundColor(Colors.red500.swiftUIColor)
          .frame(width: 19, height: 19)
      }
      .frame(width: 32, height: 32)
      .background(Colors.gray25.swiftUIColor)
      .cornerRadius(12)
      .padding(.leading, 16)
    }
    .frame(height: 92)
    .background(Colors.appWhite.swiftUIColor)
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
