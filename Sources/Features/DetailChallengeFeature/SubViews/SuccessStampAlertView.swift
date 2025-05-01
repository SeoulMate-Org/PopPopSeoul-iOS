//
//  SuccessStampAlertView.swift
//  Features
//
//  Created by suni on 5/1/25.
//

import SwiftUI
import SharedAssets
import DesignSystem

struct SuccessStampAlertView: View {
  let attractions: [String]
  let onDoneTapped: () -> Void
  
  var body: some View {    
    VStack(alignment: .center, spacing: 0) {
      VStack(alignment: .leading, spacing: 0) {
        Text("스탬프를 찍었어요!")
          .font(.appTitle2)
          .foregroundColor(Colors.appWhite.swiftUIColor)
          .padding(.top, 28)

        Text(attractions.joined(separator: ", "))
          .font(.bodyM)
          .foregroundColor(Colors.gray200.swiftUIColor)
          .lineLimit(1)
          .padding(.top, 4)
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 20)
      
      Assets.Images.completeChallenge.swiftUIImage
        .resizable()
        .scaledToFit()
        .frame(width: 280, height: 200)
        .padding(.top, 16)
      
      Button(action: onDoneTapped) {
        Text("확인")
          .font(.buttonM)
          .foregroundColor(Colors.appWhite.swiftUIColor)
          .frame(maxWidth: .infinity, minHeight: 51)
          .contentShape(Rectangle())
      }
      .buttonStyle(PlainButtonStyle()) // ✅ 기본 애니메이션 제거
      .background(Colors.blue500.swiftUIColor)
      .cornerRadius(15)
      .padding(.horizontal, 20)
      .padding(.top, 16)
      .padding(.bottom, 20)
    }
    .frame(maxWidth: 320)
    .background(Color.hex(0x0F1721))
    .cornerRadius(20)
  }
}
