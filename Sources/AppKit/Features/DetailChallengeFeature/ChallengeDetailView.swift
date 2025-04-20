//
//  ChallengeDetailView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import SwiftUI
import ComposableArchitecture
import Common

struct ChallengeDetailView: View {
  let challenge: Challenge
  @State private var showMenu = false
  @State private var isParticipating = true

  var body: some View {
    ZStack(alignment: .topTrailing) {
      VStack(spacing: 0) {
        // 헤더
        if isParticipating {
          HeaderView(type: .backWithMenu(title: "", onBack: {
            // TODO: 뒤로가기
          }, onMore: {
            showMenu = true
          }))
        } else {
          HeaderView(type: .back(title: "", onBack: { }))
        }
        
        ScrollView {
          VStack(alignment: .leading, spacing: 0) {
            DetailChallengeInfoSectionView(challenge: challenge)
            divider()
            DetailChallengeStampSectionView(challenge: challenge)
            divider()
            DetailChallengePlaceSectionView(challenge: challenge)
            divider()
            DetailChallengeCommentSectionView(challenge: challenge)
          }
        }
      }
      
      if showMenu {
        AppMoreMenu(items: [AppMoreMenuItem(title: String(sLocalization: .detailchallengeEndButton), action: {
          // TODO: 챌린지 그만 두기
        })], onDismiss: {
          showMenu = false
        }, itemHeight: 40)
        .padding(.trailing, 20)
        .offset(y: 44) // 헤더 아래 + 살짝 여유
        .transition(.opacity.combined(with: .move(edge: .top)))
        .zIndex(1) // ✅ 위에 떠야 하므로 zIndex 필요
      }
    }
  }
  
  private func divider() -> some View {
    return Divider()
      .frame(height: 2)
      .foregroundColor(Colors.gray25.swiftUIColor)
      .padding(.vertical, 28)
  }
}

// MARK: Preview

#Preview {
  ChallengeDetailView(challenge: mockChallenges[0])
}

// MARK: - Helper
