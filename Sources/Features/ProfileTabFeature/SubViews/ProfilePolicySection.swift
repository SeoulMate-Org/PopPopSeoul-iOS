//
//  ProfilePolicySection.swift
//  Features
//
//  Created by suni on 5/2/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import SharedTypes

struct ProfilePolicySection: View {
  let onServiceTapped: () -> Void
  let onPrivacyTapped: () -> Void
  let onLocationTapped: () -> Void
  
  var body: some View {
    SettingSectionContainer {
      SettingRowView(title: L10n.myListText_termsService) {
        Button(action: onServiceTapped) {
          Assets.Icons.arrowRightSmall.swiftUIImage
            .resizable()
            .frame(width: 24, height: 24)
        }
        .frame(width: 40, height: 40)
      }
      .onTapGesture {
        onServiceTapped()
      }
      .padding(.leading, 16)
      .padding(.trailing, 8)
      
      SettingRowView(title: L10n.myListText_privacyPolicy) {
        Button(action: onPrivacyTapped) {
          Assets.Icons.arrowRightSmall.swiftUIImage
            .resizable()
            .frame(width: 24, height: 24)
        }
        .frame(width: 40, height: 40)
      }
      .onTapGesture {
        onPrivacyTapped()
      }
      .padding(.leading, 16)
      .padding(.trailing, 8)
      
      SettingRowView(title: L10n.myListText_locationAgree) {
        Button(action: onLocationTapped) {
          Assets.Icons.arrowRightSmall.swiftUIImage
            .resizable()
            .frame(width: 24, height: 24)
        }
        .frame(width: 40, height: 40)
      }
      .onTapGesture {
        onLocationTapped()
      }
      .padding(.leading, 16)
      .padding(.trailing, 8)
      
    }
  }
}
