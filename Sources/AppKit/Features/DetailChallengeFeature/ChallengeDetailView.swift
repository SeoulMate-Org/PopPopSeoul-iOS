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
        
        ZStack(alignment: .bottom) {
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
            .padding(.bottom, 100)
          }
          
          if challenge.isParticipating {
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
        
        HStack(spacing: 8) {
          interestButton(isSelected: challenge.isLike, action: { })
            .frame(width: 48, height: 48)
          
          if isLogined {
            AppButton(title: String(sLocalization: .detailchallengeMapButton), size: .msize, style: .outline, layout: .textOnly, state: .enabled, onTap: { }, isFullWidth: true)
              .padding(.vertical, 10)
            
            if challenge.isParticipating {
              AppButton(title: String(sLocalization: .detailchallengeStampButton), size: .msize, style: .primary, layout: .textOnly, state: .enabled, onTap: { }, isFullWidth: true)
                .padding(.vertical, 10)
            } else {
              AppButton(title: String(sLocalization: .detailchallengeStartButton), size: .msize, style: .primary, layout: .textOnly, state: .enabled, onTap: { }, isFullWidth: true)
                .padding(.vertical, 10)
            }
          } else {
            AppButton(title: String(sLocalization: .detailchallengeLoginButton), size: .msize, style: .primary, layout: .textOnly, state: .enabled, onTap: { }, isFullWidth: true)
              .padding(.vertical, 10)
          }
        }
        .frame(height: 68)
        .padding(.horizontal, 16)
        .background(
          Color(Colors.appWhite.swiftUIColor)
            .modifier(ShadowModifier(
              shadow: AppShadow(
                color: Color(Colors.trueBlack.swiftUIColor).opacity(0.08),
                x: 0,
                y: -4,
                blur: 12,
                spread: 0
              ))
            )
            .edgesIgnoringSafeArea(.bottom)
        )
      }
      
      if showMenu {
        AppMoreMenu(items: [AppMoreMenuItem(title: String(sLocalization: .detailchallengeEndButton), action: {
          // TODO: 챌린지 그만 두기
        })], onDismiss: {
          showMenu = false
        }, itemHeight: 40)
        .padding(.trailing, 20)
        .offset(y: 44)
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
  
  private func interestButton(isSelected: Bool, action: @escaping () -> Void) -> some View {
    Button(action: action) {
      VStack(spacing: 4) {
        let icon = isSelected ? Assets.Icons.heartFill.swiftUIImage : Assets.Icons.heartLine.swiftUIImage
        icon
          .resizable()
          .foregroundStyle(isSelected ? Colors.red500.swiftUIColor : Colors.gray500.swiftUIColor)
          .frame(width: 24, height: 24)
        
        Text(String(sLocalization: .detailchallengeInterestButton))
          .font(.captionM)
      }
      .foregroundColor(Colors.gray700.swiftUIColor)
      .contentShape(Rectangle()) // 터치 영역 제한
    }
    .buttonStyle(PlainButtonStyle())
  }
}

// MARK: Preview

#Preview {
  ChallengeDetailView(challenge: mockChallenges[0])
}

// MARK: - Helper
