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

struct ProfileVersionSection: View {
  let version: String
  
  var body: some View {
    SettingSectionContainer {
      SettingRowView(title: "버전 정보") {
        Text(version)
          .font(.captionM)
          .foregroundStyle(Colors.blue600.swiftUIColor)
          .frame(height: 24)
      }
      .padding(.horizontal, 16)
    }
  }
}
