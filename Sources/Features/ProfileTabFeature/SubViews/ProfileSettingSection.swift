//
//  ProfileSettingSection.swift
//  Features
//
//  Created by suni on 5/2/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import SharedTypes

struct ProfileSettingSection: View {
  let language: String
  @Binding var isLocationAuth: Bool
  let onLanguageTapped: () -> Void
  let onNotiTapped: () -> Void
  let onLocationTapped: (Bool) -> Void
  
  var body: some View {
    VStack(alignment: .center, spacing: 4) {
      SettingRowView(title: "언어") {
        Button(action: onLanguageTapped) {
          Text(language)
            .font(.captionM)
            .foregroundStyle(Colors.blue500.swiftUIColor)
        }
        .frame(height: 24)
      }
      .padding(.horizontal, 16)
      
      SettingRowView(title: "알림") {
        Button(action: onNotiTapped) {
          Assets.Icons.arrowRightSmall.swiftUIImage
            .resizable()
            .frame(width: 24, height: 24)
        }
        .frame(width: 40, height: 40)
      }
      .padding(.leading, 16)
      .padding(.trailing, 8)
      
      SettingRowView(title: "위치 권한 설정", subTitle: "(선택)") {
        Toggle("", isOn: $isLocationAuth)
          .labelsHidden()
          .frame(width: 46, height: 28)
      }
      .padding(.leading, 16)
      .padding(.trailing, 12)
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
