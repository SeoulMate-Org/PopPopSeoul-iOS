//
//  LikeAttractionEmptyView.swift
//  Features
//
//  Created by suni on 5/2/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import SharedTypes

struct LikeAttractionEmptyView: View {
  var body: some View {
    VStack(spacing: 28) {
      Assets.Images.emptyPop.swiftUIImage
        .resizable()
        .scaledToFit()
        .frame(width: 100, height: 100)
      VStack(spacing: 8) {
        Text(L10n.myJJIMContent_havenot)
          .font(.appTitle3)
          .foregroundColor(Colors.gray900.swiftUIColor)
        Text(L10n.myJJIMContent_addMore)
          .font(.bodyS)
          .foregroundColor(Colors.gray300.swiftUIColor)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.clear)
  }
}
