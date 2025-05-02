//
//  ProfileServiceSection.swift
//  Features
//
//  Created by suni on 5/2/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import SharedTypes

struct ProfileServiceSection: View {
  let onTermsTapped: () -> Void
  let onFAQTapped: () -> Void
  
  var body: some View {
    VStack(alignment: .center, spacing: 4) {
      
      SettingRowView(title: "서비스 소개") {
        Button(action: onTermsTapped) {
          Assets.Icons.arrowRightSmall.swiftUIImage
            .resizable()
            .frame(width: 24, height: 24)
        }
        .frame(width: 40, height: 40)
      }
      .padding(.leading, 16)
      .padding(.trailing, 8)
      
      
      SettingRowView(title: "자주 묻는 질문") {
        Button(action: onFAQTapped) {
          Assets.Icons.arrowRightSmall.swiftUIImage
            .resizable()
            .frame(width: 24, height: 24)
        }
        .frame(width: 40, height: 40)
      }
      .padding(.leading, 16)
      .padding(.trailing, 8)
      
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 8)
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(Colors.appWhite.swiftUIColor)
    )
    .padding(.horizontal, 20)
  }
}
