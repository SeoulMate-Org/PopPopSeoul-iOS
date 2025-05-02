//
//  WithdrawView.swift
//  Features
//
//  Created by suni on 5/3/25.
//

import SwiftUI
import ComposableArchitecture
import Common
import DesignSystem
import SharedAssets
import SharedTypes
import Models

struct WithdrawView: View {
  let store: StoreOf<WithdrawFeature>
  @ObservedObject var viewStore: ViewStore<WithdrawFeature.State, WithdrawFeature.Action>
  
  init(store: StoreOf<WithdrawFeature>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
    VStack(spacing: 0) {
      HeaderView(type: .back(title: "탈퇴하기", onBack: {
        viewStore.send(.tappedBack)
      }))
      
      VStack(alignment: .leading, spacing: 0) {
        Text("저희 서비스를 아껴주셔서 진심으로 감사합니다.")
          .font(.appTitle3)
          .foregroundStyle(Colors.gray900.swiftUIColor)
          .padding(.top, 36)
        
        Text("고객님이 느끼신 점을 공유해주시면,\n앞으로 더 나은 서비스를 제공할 수 있도록 노력하겠습니다.")
          .font(.bodyS)
          .foregroundStyle(Colors.gray600.swiftUIColor)
          .lineSpacing(7)
          .padding(.top, 8)
        
        Divider()
          .frame(height: 1)
          .foregroundStyle(Colors.gray50.swiftUIColor)
          .padding(.top, 31)
        
        Text("유의사항")
          .font(.appTitle3)
          .foregroundStyle(Colors.gray900.swiftUIColor)
          .padding(.top, 36)
        
        VStack(alignment: .leading, spacing: 11) {
          noticeRow("내 배지, 나의 챌린지, 나의 스탬프는 삭제되면 복구되지 않습니다.")
          noticeRow("좋아요한 챌린지 또는 장소, 달성한 스탬프 수는 서비스 품질을 위해 집계 정보로 활용될 수 있습니다.")
          noticeRow("재가입 시 신규 가입으로 진행되어 기존 정보는 연동되지 않습니다.")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(
          RoundedRectangle(cornerRadius: 16)
            .fill(Colors.gray25.swiftUIColor)
        )
        .cornerRadius(16)
        .padding(.top, 12)
        
        Spacer()
                
        HStack(spacing: 10) {
          AppButton(title: "취소", size: .lsize, style: .neutral, layout: .textOnly, state: .enabled, onTap: { viewStore.send(.tappedBack) }, isFullWidth: true)
          AppButton(title: "탈퇴하기", size: .lsize, style: .primary, layout: .textOnly, state: .enabled, onTap: { viewStore.send(.showAlert) }, isFullWidth: true)
        }
        .frame(height: 51)
        .padding(.vertical, 10)
      }
      .padding(.horizontal, 20)
    }
    .background(Colors.appWhite.swiftUIColor)
    .overlay(
      Group {
        if viewStore.showAlert {
          AppAlertView(
            title: "탈퇴를 진행할까요?",
            message: "탈퇴 시 모든 챌린지 기록, 뱃지, 계정 정보는 즉시 삭제되며 복구가 불가능합니다.",
            primaryButtonTitle: "탈퇴",
            primaryAction: {
              viewStore.send(.tappedWithdraw)
            },
            secondaryButtonTitle: "취소",
            secondaryAction: {
              viewStore.send(.dismissAlert)
            })
        }
      }
    )
    .navigationBarBackButtonHidden(true)
  }
  
  private func noticeRow(_ text: String) -> some View {
    HStack(alignment: .top) {
      circle()
      Text(text)
        .font(.bodyS)
        .foregroundStyle(Colors.gray600.swiftUIColor)
        .lineSpacing(7)
    }
  }

  private func circle() -> some View {
    Circle()
      .frame(width: 3, height: 3)
      .foregroundColor(Colors.gray600.swiftUIColor)
      .padding(.horizontal, 6)
      .padding(.vertical, 8)
  }
}
