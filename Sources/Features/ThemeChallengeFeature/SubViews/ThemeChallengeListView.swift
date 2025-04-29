//
//  ThemeChallengeListView.swift
//  Features
//
//  Created by suni on 4/29/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import SharedTypes
import Models
import Clients

struct ThemeChallengeListView: View {
  let challenges: [Challenge]
  let onTapped: (Int) -> Void
  let onLikeTapped: (Int) -> Void
  @Binding var shouldScrollToTop: Bool
  
  var body: some View {
    ScrollViewReader { proxy in
      ScrollView {
        Color.clear
          .frame(height: 0)
          .id("top")
        
        if !TokenManager.shared.isLogin {
          ThemeLoginPromptSection()
            .padding(.top, 24)
        }
        LazyVStack(alignment: .leading, spacing: 16) {
          ForEach(challenges) { challenge in
            VStack(spacing: 4) {
              ThemeChallengeListItemView(
                listType: .detail,
                challenge: challenge,
                onLikeTapped: {
                  onLikeTapped(challenge.id)
                }
              )
              .padding(.horizontal, 20)
              .onTapGesture {
                onTapped(challenge.id)
              }
            }
          }
        }
        .padding(.top, 24)
        
        Text("🤩 더 많은 챌린지를 준비중이에요!")
          .font(.bodyM)
          .foregroundStyle(Colors.gray600.swiftUIColor)
          .frame(maxWidth: .infinity)
          .frame(height: 51, alignment: .center)
          .padding(.vertical, 16)
      }
      .onChange(of: shouldScrollToTop, initial: true) { _, newValue  in        
        if newValue {
          shouldScrollToTop = false
          proxy.scrollTo("top", anchor: .top)
        }
      }
    }
  }
}
