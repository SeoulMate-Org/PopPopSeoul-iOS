//
//  BadgeCardView.swift
//  Features
//
//  Created by suni on 5/2/25.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import Common
import SharedAssets
import Models

struct BadgeCardView: View {
  let badge: MyBadge

  var body: some View {
    VStack(spacing: 0) {
      if let theme = badge.theme {
        let image = badge.completeCount > 0 ? theme.badge : theme.badgeDisable
        image
          .resizable()
          .scaledToFit()
          .frame(width: 74, height: 74)
      } else {
        Color.clear
          .frame(width: 74, height: 74)
      }

      Text(badge.themeName)
        .font(.captionM)
        .lineLimit(2)
        .frame(height: 29)
        .foregroundStyle(Colors.gray900.swiftUIColor)

      HStack(spacing: 4) {
        Text("\(badge.completeCount)")
          .font(.bodyM)
          .foregroundStyle(badge.completeCount > 0 ? Colors.blue500.swiftUIColor : Colors.gray300.swiftUIColor)

        Text("/")
          .font(.captionM)
          .foregroundStyle(Colors.gray300.swiftUIColor)

        Text("\(badge.themeCount)")
          .font(.captionM)
          .foregroundStyle(Colors.gray300.swiftUIColor)
      }
      .frame(height: 19)
      .padding(.bottom, 8)
    }
    .frame(height: 130)
    .frame(maxWidth: .infinity)
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(Colors.appWhite.swiftUIColor)
    )
  }
}
