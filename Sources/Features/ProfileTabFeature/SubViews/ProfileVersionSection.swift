//
//  ProfileVersionSection.swift
//  Features
//
//  Created by suni on 5/2/25.
//

import SwiftUI
import DesignSystem
import SharedAssets
import SharedTypes
import Common

struct ProfileVersionSection: View {
  let version: String
  
  var body: some View {
    SettingSectionContainer {
      SettingRowView(title: L10n.myListText_version) {
        Text(version)
          .font(.captionM)
          .foregroundStyle(Colors.gray600.swiftUIColor)
          .frame(height: 24)
      }
      .padding(.horizontal, 16)
    }
  }
}
