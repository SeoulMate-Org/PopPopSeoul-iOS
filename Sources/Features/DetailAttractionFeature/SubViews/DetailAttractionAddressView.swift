//
//  DetailAttractionAddressView.swift
//  Features
//
//  Created by suni on 4/30/25.
//

import SwiftUI
import Common
import SharedAssets
import SharedTypes
import Models
import DesignSystem

struct DetailAttractionAddressView: View {
  let text: String
  let distance: String?
  let onPasteTapped: () -> Void
  
  @State private var isExpanded: Bool = false
  
  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      Assets.Icons.mapLine.swiftUIImage
        .resizable()
        .frame(width: 18, height: 18)
        .foregroundStyle(Colors.gray400.swiftUIColor)
        .padding(.top, 8)
      
      VStack(alignment: .leading, spacing: 0) {
        HStack(alignment: .top, spacing: 0) {
          HStack(alignment: .bottom) {
            Text(text)
              .lineLimit(isExpanded ? nil : 1)
              .multilineTextAlignment(.leading)
              .font(.bodyS)
              .foregroundStyle(Colors.gray900.swiftUIColor)
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.vertical, 8)
            
            Button(action: {
              withAnimation {
                isExpanded.toggle()
              }
            }) {
              (isExpanded ? Assets.Icons.arrowUpperSmall.swiftUIImage : Assets.Icons.arrowUnderSmall.swiftUIImage)
                .foregroundStyle(Colors.gray400.swiftUIColor)
                .frame(width: 24, height: 24)
            }
            .frame(width: 32, height: 32)
          } // HStack (bottom)
          
          Button(action: {
            onPasteTapped()
            UIPasteboard.general.string = text
          }) {
            Text(L10n.textButton_copy)
              .foregroundStyle(Colors.blue500.swiftUIColor)
              .font(.buttonS)
          }
          .frame(width: 54, height: 32)
        } // HStack (top)
        
        // 하단 서브텍스트 (거리 등)
        if let distance {
          HStack(alignment: .center, spacing: 6) {
            Assets.Icons.route.swiftUIImage
              .resizable()
              .frame(width: 16, height: 16)
              .foregroundStyle(Colors.blue500.swiftUIColor)
              .padding(.horizontal, 4)
              .padding(.vertical, 4)
              .background(
                RoundedRectangle(cornerRadius: 10)
                  .fill(Colors.blue50.swiftUIColor)
              )
            
            Text(L10n.subText_away(distance))
              .font(.bodyS)
              .foregroundStyle(Colors.gray900.swiftUIColor)
          }
        }
      } // VStack (leading)
    } // HStack (top)
  }
}
