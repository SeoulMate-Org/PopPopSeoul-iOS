//
//  ProfileSettingSection.swift
//  Features
//
//  Created by suni on 5/2/25.
//

import SwiftUI
import DesignSystem
import SharedAssets
import SharedTypes
import Common

struct ProfileSettingSection: View {
  let language: String
  @Binding var isLocationAuth: Bool
  let onLanguageTapped: () -> Void
  let onNotiTapped: () -> Void
  let onLocationTapped: (Bool) -> Void

  var body: some View {
    SettingSectionContainer {
      SettingRowView(title: L10n.myListText_language) {
        Button(action: onLanguageTapped) {
          Text(language)
            .font(.captionM)
            .foregroundStyle(Colors.blue500.swiftUIColor)
        }
        .frame(height: 24)
      }
      .padding(.horizontal, 16)

      SettingRowView(title: L10n.myListText_notifications) {
        Button(action: onNotiTapped) {
          Assets.Icons.arrowRightSmall.swiftUIImage
            .resizable()
            .frame(width: 24, height: 24)
        }
        .frame(width: 40, height: 40)
      }
      .padding(.leading, 16)
      .padding(.trailing, 8)

      SettingRowView(title: L10n.myListText_locationAccess, subTitle: L10n.myListText_optional) {
        Toggle("", isOn: $isLocationAuth)
          .foregroundStyle(Colors.blue500.swiftUIColor)
          .labelsHidden()
          .frame(width: 46, height: 28)
      }
      .padding(.leading, 16)
      .padding(.trailing, 12)
    }
  }
}
