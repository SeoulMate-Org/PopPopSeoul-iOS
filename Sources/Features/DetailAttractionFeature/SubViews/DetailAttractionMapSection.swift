//
//  DetailAttractionMapSection.swift
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

struct DetailAttractionMapSection: View {
  let image: Image
  let onMapTapped: () -> Void
  
  var body: some View {
    let imageWidth = UIScreen.main.bounds.width - 40
    
    ZStack(alignment: .bottomTrailing) {
      // 이미지
      image
        .resizable()
        .scaledToFill()
        .frame(width: imageWidth, height: imageWidth * 200 / 335)
        .clipped()
      
      Button(action: {
        onMapTapped()
      }) {
        HStack(spacing: 2) {
          Text(L10n.textButton_viewNaverMap)
            .font(.buttonS)
            .foregroundColor(Colors.blue500.swiftUIColor)
            .padding(.vertical, 9)
            .padding(.leading, 10)
          
          Assets.Icons.arrowRightLine.swiftUIImage
            .resizable()
            .scaledToFit()
            .frame(width: 16, height: 16)
            .foregroundColor(Colors.blue500.swiftUIColor)
            .padding(.trailing, 10)
        }
      }
      .frame(height: 32)
      .background(Colors.appWhite.swiftUIColor)
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .stroke(Colors.blue200.swiftUIColor, lineWidth: 1.5)
      )
      .cornerRadius(10, corners: .allCorners)
      .padding(.bottom, 10)
      .padding(.trailing, 10)
    }
    .frame(width: imageWidth, height: imageWidth * 200 / 335)
    .overlay(
      RoundedRectangle(cornerRadius: 16)
        .stroke(Colors.gray25.swiftUIColor, lineWidth: 1)
    )
    .cornerRadius(16, corners: .allCorners)
    .padding(.horizontal, 20)
  }
}
