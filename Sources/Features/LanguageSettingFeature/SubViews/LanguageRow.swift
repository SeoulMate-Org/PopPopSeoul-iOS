//
//  LanguageRow.swift
//  Features
//
//  Created by suni on 5/3/25.
//

import SwiftUI
import DesignSystem
import SharedAssets
import SharedTypes

struct LanguageRow: View {
  let title: String
  let isSelected: Bool
  let onTap: () -> Void

  var body: some View {
    HStack(spacing: 6) {
      Button(action: onTap) {
        let image = isSelected ? Assets.Icons.radioSelected.swiftUIImage : Assets.Icons.radio.swiftUIImage
        image
          .resizable()
          .frame(width: 24, height: 24)
          .foregroundStyle(isSelected ? Colors.blue500.swiftUIColor : Colors.gray600.swiftUIColor)
      }
      .frame(width: 40, height: 40)

      Text(title)
        .font(.bodyM)
        .foregroundStyle(isSelected ? Colors.gray900.swiftUIColor : Colors.gray600.swiftUIColor)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .contentShape(Rectangle()) // 터치 영역 확장
    .onTapGesture(perform: onTap)
  }
}
