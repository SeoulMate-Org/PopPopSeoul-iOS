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
        Text("아직 찜한 장소가 없어요!")
          .font(.appTitle3)
          .foregroundColor(Colors.gray900.swiftUIColor)
        Text("여러 챌린지를 찾아보고 추가하세요.")
          .font(.bodyS)
          .foregroundColor(Colors.gray300.swiftUIColor)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.clear)
  }
}
