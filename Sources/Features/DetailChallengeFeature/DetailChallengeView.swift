//
//  DetailChallengeView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import SwiftUI
import ComposableArchitecture
import Common
import DesignSystem
import SharedAssets

struct DetailChallengeView: View {
  let store: StoreOf<DetailChallengeFeature>
  
  init(store: StoreOf<DetailChallengeFeature>) {
    self.store = store
  }
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack(alignment: .topTrailing) {
        VStack(spacing: 0) {
          // 헤더
          if viewStore.challenge?.challengeStatus == .progress {
            HeaderView(type: .backWithMenu(title: "", onBack: {
              viewStore.send(.tappedBack)
            }, onMore: {
              viewStore.send(.tappedMore)
            }))
          } else {
            HeaderView(type: .back(title: "", onBack: {
              viewStore.send(.tappedBack)
            }))
          }
          
          ZStack(alignment: .bottom) {
            ScrollView {
              VStack(alignment: .leading, spacing: 0) {
                if let challenge = viewStore.challenge {
                  DetailChallengeInfoSection(challenge: challenge)
                  divider()
                  //                DetailChallengeStampSection(challenge: challenge)
                  //                divider()
                  //                DetailChallengePlaceSection(challenge: challenge)
                  //                divider()
                  //                DetailChallengeCommentSection(challenge: challenge)
                }
              }
              .padding(.bottom, 100)
            }
            
            if viewStore.challenge?.challengeStatus == .progress {
              Text(String(sLocalization: .detailchallengeFloatingText))
                .font(.captionM)
                .foregroundColor(Colors.blue500.swiftUIColor)
                .padding(.vertical, 11)
                .padding(.horizontal, 24)
                .background(Color.hex(0xEDF4FF))
                .overlay(
                  RoundedRectangle(cornerRadius: 18)
                    .stroke(Colors.blue400.swiftUIColor, lineWidth: 1)
                )
                .cornerRadius(18)
                .padding(.bottom, 10)
                .background(Color.clear)
                .edgesIgnoringSafeArea(.all)
            }
          }
        }
        
        //        DetailChallengeBottomSection(challenge: challenge)
        
        if viewStore.showMenu {
          AppMoreMenu(items: [AppMoreMenuItem(title: String(sLocalization: .detailchallengeEndButton), action: {
            viewStore.send(.quitChallenge)
          })], onDismiss: {
            viewStore.send(.dismissMenu)
          }, itemHeight: 40)
          .padding(.trailing, 20)
          .offset(y: 44)
          .transition(.opacity.combined(with: .move(edge: .top)))
          .zIndex(1) // ✅ 위에 떠야 하므로 zIndex 필요
        }
      }
      .onAppear {
        viewStore.send(.onApear)
      }
      .navigationBarBackButtonHidden(true)
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
  //  DetailChallengeView(challenge: mockChallenges[0])
}

// MARK: - Helper
