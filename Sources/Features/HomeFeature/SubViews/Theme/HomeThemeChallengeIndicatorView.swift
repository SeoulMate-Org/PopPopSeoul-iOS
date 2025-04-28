//
//  HomeThemeChallengeIndicatorView.swift
//  Features
//
//  Created by suni on 4/24/25.
//

import SwiftUI
import SharedAssets
import SharedTypes

struct HomeThemeChallengeIndicatorView: View {
  @Binding var currentTab: ChallengeTheme
  
  var body: some View {
    HStack(spacing: 6) {
      ForEach(ChallengeTheme.sortedByPriority().indices, id: \.self) { index in
        let isSelected = index == (currentTab.priority - 1)
        Capsule()
          .fill(isSelected ? Colors.gray700.swiftUIColor : Colors.gray75.swiftUIColor)
          .frame(width: isSelected ? 16 : 8, height: 8)
      }
    }
  }
}
