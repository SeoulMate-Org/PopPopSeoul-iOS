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

struct HomeThemeChallengeSection: View {
  @Binding var selectedTab: ChallengeTheme
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      
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
            HomeThemeChallengeTab(
              tab: tab,
              isSelected: selectedTab == tab,
              onTapped: { }
            )
            .frame(height: 30)
          }
        }
        .padding(.horizontal, 20)
      }
      .padding(.top, 16)
      
      // TODO: - 챌린지 리스트 (기획 논의 중)
//      VStack {
//        Text("챌린지 리스트는 추후 구현 예정입니다.")
//          .font(.appTitle3)
//          .foregroundColor(Colors.gray400.swiftUIColor)
//      }
//      .frame(height: 200)
//      .frame(maxWidth: .infinity)
//      .padding(.top, 20)
    }
  }
}

#Preview {
  StatefulPreviewWrapper(ChallengeTheme.localExploration) { binding in
    HomeThemeChallengeSection(selectedTab: binding)
  }
}
