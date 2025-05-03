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
  let onOnboardingTapped: () -> Void
  let onFAQTapped: () -> Void
  
  var body: some View {
    SettingSectionContainer {
      SettingRowView(title: L10n.myListText_aboutService) {
        Button(action: onOnboardingTapped) {
          Assets.Icons.arrowRightSmall.swiftUIImage
            .resizable()
            .frame(width: 24, height: 24)
        }
        .frame(width: 40, height: 40)
      }
      .onTapGesture {
        onOnboardingTapped()
      }
      .padding(.leading, 16)
      .padding(.trailing, 8)
      
      SettingRowView(title: L10n.myListText_FAQ) {
        Button(action: onFAQTapped) {
          Assets.Icons.arrowRightSmall.swiftUIImage
            .resizable()
            .frame(width: 24, height: 24)
        }
        .frame(width: 40, height: 40)
      }
      .onTapGesture {
        onFAQTapped()
      }
      .padding(.leading, 16)
      .padding(.trailing, 8)
      
    }
  }
}
