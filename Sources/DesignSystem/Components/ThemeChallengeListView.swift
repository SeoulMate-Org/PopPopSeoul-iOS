//
//  ThemeChallengeListView.swift
//  Clients
//
//  Created by suni on 4/24/25.
//

import SwiftUI
import Common
import SharedAssets
import SharedTypes

public struct ThemeChallengeListView: View {
  let listType: ThemeChallengeListType
  @Binding var selectedTab: ChallengeTheme
  let challengesByTheme: [ChallengeTheme: [Challenge]]

  public init(listType: ThemeChallengeListType,
              selectedTab: Binding<ChallengeTheme>,
              challengesByTheme: [ChallengeTheme: [Challenge]]) {
    self.listType = listType
    self._selectedTab = selectedTab
    self.challengesByTheme = challengesByTheme
  }
  
  public var body: some View {
    TabView(selection: $selectedTab) {
      ForEach(ChallengeTheme.allCases, id: \.self) { theme in
        VStack(spacing: 12) {
          ForEach(challengesByTheme[theme, default: []].prefix(3)) { challenge in
            ThemeChallengeListItemView(listType: listType, challenge: challenge, onLikeTapped: { })
          }
        }
        .tag(theme)
        .padding(.horizontal, 20)
      }
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
    .frame(height: 304)
  }
}

public enum ThemeChallengeListType {
  case home
  case detail
}
