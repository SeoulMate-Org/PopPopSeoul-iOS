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
      SettingRowView(title: "서비스 소개") {
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
      
      SettingRowView(title: "자주 묻는 질문") {
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
