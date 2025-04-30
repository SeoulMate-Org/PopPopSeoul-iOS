//
//  HomeThemeSection.swift
//  Clients
//
//  Created by suni on 4/24/25.
//

import SwiftUI
import Common
import DesignSystem
import Clients
import SharedAssets
import SharedTypes
import Models

struct HomeThemeSection: View {
  @Binding var selectedTab: ChallengeTheme
  let challengesByTheme: [ChallengeTheme: [Challenge]]
  let themeTabChanged: (ChallengeTheme) -> Void
  let onLikeTapped: (Challenge) -> Void
  let onMoreTapped: () -> Void
  let onTapped: (Int) -> Void
  
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      
      // MARK: - 헤더 타이틀 + 더보기
      HStack(alignment: .bottom) {
        Text("🎡 테마별로 골라보는 챌린지")
          .font(.appTitle2)
          .foregroundStyle(Colors.gray900.swiftUIColor)
        
        Spacer()
        
        Button(action: {
          onMoreTapped()
        }) {
          Text("더보기")
            .font(.captionM)
            .foregroundColor(Colors.gray400.swiftUIColor)
        }
      }
      .frame(height: 24)
      .padding(.horizontal, 20)
      
      // MARK: - 필터 탭
      ScrollViewReader { proxy in
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 8) {
            ForEach(ChallengeTheme.sortedByPriority(), id: \.self) { tab in
              HomeThemeTabView(
                tab: tab,
                isSelected: selectedTab == tab,
                onTapped: {
                  themeTabChanged(tab)
                }
              )
              .frame(height: 30)
              .id(tab)
            }
          }
          .padding(.horizontal, 20)
        }
        .padding(.top, 16)
        .onChange(of: selectedTab, initial: false) { oldTab, newTab in
          guard oldTab != newTab else { return }
          withAnimation {
            proxy.scrollTo(newTab, anchor: .center)
          }
        }
      }
      
      HomeThemeChallengeListView(
        challengesByTheme: challengesByTheme,
        selectedTab: $selectedTab,
        onLikeTapped: onLikeTapped,
        onTapped: onTapped
      )
      .padding(.top, 20)
      
      HomeThemeIndicatorView(currentTab: $selectedTab)
        .padding(.top, 16)
    }
    .background(.clear)
  }
}
