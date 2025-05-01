//
//  ChallengePlaceListItem.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import Models
import Kingfisher

struct ChallengePlaceListItem: View {
  let place: Attraction
  let onLikeTapped: () -> Void
  
  var body: some View {
    HStack(alignment: .center, spacing: 8) {
      ZStack(alignment: .bottomTrailing) {
        KFImage( URL(string: place.imageUrl))
          .placeholder {
            Assets.Images.placeholderImage.swiftUIImage
              .resizable()
              .scaledToFill()
          }.retry(maxCount: 2, interval: .seconds(5))
          .resizable()
          .scaledToFill()
          .frame(width: 76, height: 76)
          .clipShape(RoundedRectangle(cornerRadius: 16))
        
        if place.isStamped {
          Assets.Images.stampActive.swiftUIImage
            .resizable()
            .frame(width: 28, height: 28)
            .padding(.bottom, 4)
            .padding(.trailing, 4)
        }
      }
      
      VStack(alignment: .leading, spacing: 4) {
        Text(place.name)
          .font(.bodyM)
          .foregroundColor(Colors.gray900.swiftUIColor)
          .lineLimit(2)
        
        HStack(spacing: 6) {
          
          if place.likes > 0 {
            HStack(spacing: 2) {
              Assets.Icons.heartFill.swiftUIImage
                .resizable()
                .foregroundColor(Colors.gray100.swiftUIColor)
                .frame(width: 16, height: 16)
              
              Text("\(place.likes)")
                .font(.captionL)
                .foregroundColor(Colors.gray300.swiftUIColor)
            }
          }
          
          if place.stampCount > 0 {
            HStack(spacing: 2) {
              Assets.Icons.profileFill.swiftUIImage
                .resizable()
                .foregroundColor(Colors.gray100.swiftUIColor)
                .frame(width: 16, height: 16)
              
              Text("\(place.stampCount)")
                .font(.captionL)
                .foregroundColor(Colors.gray300.swiftUIColor)
            }
          }
        }
        
        HStack(spacing: 4) {
          Assets.Icons.route.swiftUIImage
            .resizable()
            .foregroundColor(Colors.gray100.swiftUIColor)
            .frame(width: 16, height: 16)
          
          if let distance = place.distance {
            Text("나로부터 \(distance.formattedDistance)")
              .font(.captionL)
              .foregroundColor(Colors.gray400.swiftUIColor)
          }
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      VStack {
        Spacer()
        Button(action: {
          onLikeTapped()
        }) {
          if place.isLiked {
            Assets.Icons.heartFill.swiftUIImage
              .foregroundColor(Colors.red500.swiftUIColor)
              .frame(width: 24, height: 24)
          } else {
            Assets.Icons.heartLine.swiftUIImage
              .foregroundColor(Colors.gray200.swiftUIColor)
              .frame(width: 24, height: 24)
          }
        }
        .frame(width: 40, height: 40)
        .background(Colors.gray25.swiftUIColor)
        .cornerRadius(16)
        Spacer()
      }
      .padding(.leading, 16)
    }
    .background(.clear)
    .frame(height: 101)
  }
}
