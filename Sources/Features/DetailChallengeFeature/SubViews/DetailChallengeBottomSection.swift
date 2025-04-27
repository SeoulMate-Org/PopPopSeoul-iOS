//
//  DetailChallengeBottomSection.swift
//  Common
//
//  Created by suni on 4/26/25.
//

import SwiftUI
import ComposableArchitecture
import Common
import DesignSystem
import SharedAssets
import Models
import Clients

struct DetailChallengeBottomSection: View {
  let challenge: DetailChallenge
  let onTap: (DetailChallengeFeature.BottomAction) -> ()
  
  var body: some View {
    HStack(spacing: 8) {
      interestButton(isSelected: challenge.isLiked, action: { onTap(.like) })
        .frame(width: 48, height: 48)
      
      if TokenManager.shared.isLogin {
        AppButton(title: String(sLocalization: .detailchallengeMapButton), size: .msize, style: .outline, layout: .textOnly, state: .enabled, onTap: { onTap(.map) }, isFullWidth: true)
          .padding(.vertical, 10)
        
        if challenge.challengeStatus == .progress {
          AppButton(title: String(sLocalization: .detailchallengeStampButton), size: .msize, style: .primary, layout: .textOnly, state: .enabled, onTap: { onTap(.stamp) }, isFullWidth: true)
            .padding(.vertical, 10)
        } else {
          // TODO: - 미진행 사용자 분리
          AppButton(title: String(sLocalization: .detailchallengeStartButton), size: .msize, style: .primary, layout: .textOnly, state: .enabled, onTap: { onTap(.start) }, isFullWidth: true)
            .padding(.vertical, 10)
        }
      } else {
        AppButton(title: String(sLocalization: .detailchallengeLoginButton), size: .msize, style: .primary, layout: .textOnly, state: .enabled, onTap: { onTap(.login) }, isFullWidth: true)
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

// MARK: - Helper
