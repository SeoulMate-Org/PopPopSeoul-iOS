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
import Models

public struct ThemeChallengeListView: View {
  let listType: ThemeChallengeListType
  let challengesByTheme: [ChallengeTheme: [MyChallenge]]
  @Binding var selectedTab: ChallengeTheme
  let onLikeTapped: (Int) -> Void

  public init(listType: ThemeChallengeListType,
              challengesByTheme: [ChallengeTheme: [MyChallenge]],
              selectedTab: Binding<ChallengeTheme>,
              onLikeTapped: @escaping (Int) -> Void) {
    self.listType = listType
    self._selectedTab = selectedTab
    self.challengesByTheme = challengesByTheme
    self.onLikeTapped = onLikeTapped
  }
  
  public var body: some View {
    TabView(selection: $selectedTab) {
      ForEach(ChallengeTheme.sortedByPriority(), id: \.self) { theme in
        VStack(spacing: 12) {
          ForEach(challengesByTheme[theme, default: []].prefix(3)) { challenge in
            ThemeChallengeListItemView(
              listType: listType,
              challenge: challenge,
              onLikeTapped: {
                onLikeTapped(challenge.id)
              }
            )
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
