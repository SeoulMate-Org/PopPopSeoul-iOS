//
//  ProfileLoginSection.swift
//  Features
//
//  Created by suni on 5/2/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import SharedTypes

struct ProfileLoginSection: View {
  let onLogoutTapped: () -> Void
  let onWithdrawTapped: () -> Void
  
  var body: some View {
    SettingSectionContainer {
      SettingRowView(title: "로그아웃") {
        EmptyView()
      }
      .onTapGesture {
        onLogoutTapped()
      }
      .padding(.horizontal, 16)
      
      SettingRowView(title: "탈퇴하기") {
        EmptyView()
      }
      .onTapGesture {
        onWithdrawTapped()
      }
      .padding(.horizontal, 16)
    }
  }
}
