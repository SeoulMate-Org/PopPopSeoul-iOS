//
//  AttractionMapListItem.swift
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

struct AttractionMapListItem: View {
  let attraction: Attraction
  let onLikeTapped: () -> Void
  
  @State private var isExpanded: Bool = false
  
  var body: some View {
    VStack {
      Spacer()
      HStack(alignment: .top, spacing: 8) {
        KFImage( URL(string: attraction.imageUrl))
          .placeholder {
            Assets.Images.placeholderImage.swiftUIImage
              .resizable()
              .scaledToFill()
          }.retry(maxCount: 2, interval: .seconds(5))
          .resizable()
          .frame(width: 36, height: 36)
          .clipShape(RoundedRectangle(cornerRadius: 10))
        
        VStack(alignment: .leading, spacing: 0) {
          Text(attraction.name + attraction.name + attraction.name + attraction.name + attraction.name + attraction.name)
            .font(.bodyM)
            .foregroundColor(Colors.gray900.swiftUIColor)
            .lineLimit(2)
          
          HStack(alignment: .bottom) {
            Text(attraction.name + attraction.name + attraction.name + attraction.name + attraction.name + attraction.name)
              .lineLimit(isExpanded ? nil : 1)
              .multilineTextAlignment(.leading)
              .font(.captionL)
              .foregroundStyle(Colors.gray300.swiftUIColor)
              .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {
              withAnimation {
                isExpanded.toggle()
              }
            }) {
              (isExpanded ? Assets.Icons.arrowUpperSmall.swiftUIImage : Assets.Icons.arrowUnderSmall.swiftUIImage)
                .foregroundStyle(Colors.gray300.swiftUIColor)
                .frame(width: 24, height: 24)
            }
            .frame(width: 24, height: 24)
          } // HStack (bottom)
          .padding(.top, 4)
        } // VStack (leading)
        
        VStack {
          Spacer()
          Button(action: {
            onLikeTapped()
          }) {
            if attraction.isLiked {
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
      }
      Spacer()
    }
    .frame(height: 88)
    .background(Color.clear)
  }
}
