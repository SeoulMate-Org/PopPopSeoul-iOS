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
import DesignSystem

public struct HomeThemeChallengeListView: View {
  let challengesByTheme: [ChallengeTheme: [Challenge]]
  @Binding var selectedTab: ChallengeTheme
  let onLikeTapped: (Challenge) -> Void
  let onTapped: (Int) -> Void

  public init(challengesByTheme: [ChallengeTheme: [Challenge]],
              selectedTab: Binding<ChallengeTheme>,
              onLikeTapped: @escaping (Challenge) -> Void,
              onTapped: @escaping (Int) -> Void) {
    self._selectedTab = selectedTab
    self.challengesByTheme = challengesByTheme
    self.onLikeTapped = onLikeTapped
    self.onTapped = onTapped
  }
  
  public var body: some View {
    TabView(selection: $selectedTab) {
      ForEach(ChallengeTheme.sortedByPriority(), id: \.self) { theme in
        VStack(spacing: 12) {
          ForEach(challengesByTheme[theme, default: []].prefix(3)) { challenge in
            ThemeChallengeListItemView(
              listType: .home,
              challenge: challenge,
              onLikeTapped: {
                onLikeTapped(challenge)
              }
            )
            .onTapGesture {
              onTapped(challenge.id)
            }
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
