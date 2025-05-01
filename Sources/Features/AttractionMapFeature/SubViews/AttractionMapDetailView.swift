//
//  AttractionMapDetailView.swift
//  Features
//
//  Created by suni on 5/1/25.
//

import SwiftUI
import Common
import SharedTypes
import Models
import SharedAssets
import DesignSystem

struct AttractionMapDetailView: View {
  let attraction: Attraction
  let onDetailTapped: () -> Void
  let onLikeTapped: () -> Void
  
  @State private var isExpanded: Bool = false
  
  var body: some View {
    VStack {
      HStack(alignment: .top, spacing: 16) {
        VStack(alignment: .leading) {
          Text(attraction.name)
            .font(.bodyM)
            .foregroundColor(Colors.gray900.swiftUIColor)
            .lineLimit(2)
          
          Text(attraction.address)
            .lineLimit(isExpanded ? nil : 2)
            .multilineTextAlignment(.leading)
            .font(.captionL)
            .foregroundStyle(Colors.gray300.swiftUIColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 6)
          
          HStack(alignment: .center, spacing: 0) {
            if let distance = attraction.distance {
              Assets.Icons.route.swiftUIImage
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(Colors.blue500.swiftUIColor)
                .background(
                  RoundedRectangle(cornerRadius: 10)
                    .fill(Colors.blue50.swiftUIColor)
                )
              
              Text("\(distance.formattedDistance)")
                .font(.bodyS)
                .foregroundStyle(Colors.gray900.swiftUIColor)
                .padding(.leading, 8)
              
              Rectangle()
                .frame(width: 1, height: 16)
                .foregroundColor(Colors.gray300.swiftUIColor)
                .padding(.horizontal, 8)
            }
            
            Assets.Icons.heartFill.swiftUIImage
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(Colors.gray200.swiftUIColor)
              
            Text("\(attraction.likes)")
                .font(.bodyS)
                .foregroundStyle(Colors.gray900.swiftUIColor)
                .padding(.leading, 4)
          }
          .padding(.top, 6)
        }
        .padding(.leading, 8)
        
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
      }
      .padding(.top, 20)
      .padding(.horizontal, 20)
      
      HStack(spacing: 10) {
        AppButton(
          title: "Copy Address",
          size: .msize,
          style: .neutral,
          layout: .textOnly,
          state: .enabled,
          onTap: {
            UIPasteboard.general.string = attraction.address
          },
          horizontalPadding: 15
        )
        .frame(width: 140)
        .frame(maxHeight: 46)
        
        AppButton(
          title: "장소 상세보기",
          size: .msize,
          style: .primary,
          layout: .textOnly,
          state: .enabled,
          onTap: { onDetailTapped() },
          isFullWidth: true
        )
        .frame(maxHeight: 46)
      }
      .padding(.vertical, 16)
      .padding(.horizontal, 20)
    }
    .background(Colors.appWhite.swiftUIColor)
  }
}
