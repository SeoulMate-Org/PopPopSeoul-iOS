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
      HeaderView(type: .back(title: L10n.myListButtonText_deleteAccount, onBack: {
        viewStore.send(.tappedBack)
      }))
      
      VStack(alignment: .leading, spacing: 0) {
        Text(L10n.withdrawexplanation_thankyou)
          .font(.appTitle3)
          .foregroundStyle(Colors.gray900.swiftUIColor)
          .padding(.top, 36)
        
        // FIXME: - 1차 오픈 히든
//        Text("고객님이 느끼신 점을 공유해주시면,\n앞으로 더 나은 서비스를 제공할 수 있도록 노력하겠습니다.")
//          .font(.bodyS)
//          .foregroundStyle(Colors.gray600.swiftUIColor)
//          .lineSpacing(7)
//          .padding(.top, 8)
        
        Divider()
          .frame(height: 1)
          .foregroundStyle(Colors.gray50.swiftUIColor)
          .padding(.top, 31)
        
        Text(String(sLocalization: .withdrawNote))
          .font(.appTitle3)
          .foregroundStyle(Colors.gray900.swiftUIColor)
          .padding(.top, 36)
        
        VStack(alignment: .leading, spacing: 11) {
          noticeRow(L10n.withdrawexplanation_description_1)
          noticeRow(L10n.withdrawexplanation_description_2)
          noticeRow(L10n.withdrawexplanation_description_3)
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
          AppButton(title: L10n.textButton_cancel, size: .lsize, style: .neutral, layout: .textOnly, state: .enabled, onTap: { viewStore.send(.tappedBack) }, isFullWidth: true)
          AppButton(title: L10n.detailmenuItem_deleteAccount, size: .lsize, style: .primary, layout: .textOnly, state: .enabled, onTap: { viewStore.send(.showAlert) }, isFullWidth: true)
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
            title: L10n.alertTitle_deleteAccount,
            message: L10n.alertContent_deleteAccount,
            primaryButtonTitle: L10n.textButton_deleteAccount,
            primaryAction: {
              viewStore.send(.tappedWithdraw)
            },
            secondaryButtonTitle: L10n.textButton_cancel,
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
