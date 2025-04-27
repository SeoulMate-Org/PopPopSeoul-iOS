//
//  HomeThemeChallengeSection.swift
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

struct HomeThemeChallengeSection: View {
  @Binding var selectedTab: ChallengeTheme
  let challengesByTheme: [ChallengeTheme: [Challenge]]
  let themeTabChanged: (ChallengeTheme) -> ()
  
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      
      // MARK: - 헤더 타이틀 + 더보기
      HStack(alignment: .bottom) {
        Text("🎡 테마별로 골라보는 챌린지")
          .font(.appTitle2)
          .foregroundStyle(Colors.gray900.swiftUIColor)
        
        Spacer()
        
        Button(action: {
          // TODO: 더보기 액션
        }) {
          Text("더보기")
            .font(.captionM)
            .foregroundColor(Colors.gray400.swiftUIColor)
        }
      }
      .frame(height: 24)
      .padding(.horizontal, 20)
      
      // MARK: - 필터 탭
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 8) {
          ForEach(ChallengeTheme.allCases, id: \.self) { tab in
            HomeThemeChallengeTabView(
              tab: tab,
              isSelected: selectedTab == tab,
              onTapped: { themeTabChanged(tab) }
            )
            .frame(height: 30)
          }
        }
        .padding(.horizontal, 20)
      }
      .padding(.top, 16)
      
      ThemeChallengeListView(
        listType: .home,
        selectedTab: $selectedTab,
        challengesByTheme: challengesByTheme
      )
      .padding(.top, 20)
      
      HomeThemeChallengeIndicatorView(currentTab: selectedTab)
        .padding(.top, 16)
    }
  }
}

//#Preview {
//  let dummyData: [ChallengeTheme: [Challenge]] = [
//    .localExploration: mockChallenges,
//    .historyCulture: mockChallenges,
//    .artExhibition: mockChallenges,
//    .culturalEvent: mockChallenges
//  ]
//  StatefulPreviewWrapper(ChallengeTheme.localExploration) { binding in
//    HomeThemeChallengeSection(
//      selectedTab: binding,
//      challengesByTheme: dummyData,
//      themeTabChanged: { _ in })
//  }
//}
