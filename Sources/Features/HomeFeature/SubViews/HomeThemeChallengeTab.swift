//
//  HomeThemeChallengeTab.swift
//  Clients
//
//  Created by suni on 4/24/25.
//

import SwiftUI
import DesignSystem
import Common
import Clients

struct HomeThemeChallengeTab: View {
  let tab: ChallengeTheme
  let isSelected: Bool
  let onTapped: () -> Void
    
  var body: some View {
    Button(action: {
      onTapped()
    }) {
      Text(tab.title)
        .font(.captionM)
        .foregroundColor(isSelected ? Colors.blue500.swiftUIColor : Colors.gray900.swiftUIColor)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
    }
    .frame(minWidth: 67)
    .background(
      isSelected
      ? Colors.blue50.swiftUIColor
      : Colors.appWhite.swiftUIColor
    )
    .overlay(
      RoundedRectangle(cornerRadius: 12)
        .stroke(isSelected ? Colors.blue500.swiftUIColor : Colors.gray200.swiftUIColor, lineWidth: 1)
    )
    .cornerRadius(12)
  }
}

#Preview {
  HomeThemeChallengeTab(tab: .artExhibition, isSelected: true, onTapped: { })
}
