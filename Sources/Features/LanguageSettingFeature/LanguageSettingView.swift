//
//  LanguageSettingView.swift
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

struct LanguageSettingView: View {
  let store: StoreOf<LanguageSettingFeature>
  @ObservedObject var viewStore: ViewStore<LanguageSettingFeature.State, LanguageSettingFeature.Action>
  
  init(store: StoreOf<LanguageSettingFeature>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
    VStack(spacing: 0) {
      HeaderView(type: .back(title: "언어", onBack: {
        viewStore.send(.tappedBack)
      }))
      
      VStack(alignment: .leading, spacing: 12) {
        Text("사용할 언어를 선택해주세요")
          .font(.appTitle3)
          .foregroundStyle(Colors.gray900.swiftUIColor)
        
        LanguageRow(
          title: "한국어",
          isSelected: viewStore.language == .kor,
          onTap: { viewStore.send(.tappedLanguage(.kor)) }
        )
        
        LanguageRow(
          title: "영어",
          isSelected: viewStore.language == .eng,
          onTap: { viewStore.send(.tappedLanguage(.eng)) }
        )
      }
      .padding(.top, 36)
      .padding(.horizontal, 20)
      
      Spacer()
    }
    .background(Colors.appWhite.swiftUIColor)
    .onAppear {
      viewStore.send(.onAppear)
    }
    .overlay(
      Group {
        if viewStore.showAlert {
          AppAlertView(
            title: "언어를 변경할까요?",
            message: "앱이 새로고침되며 변경된 언어가 적용돼요.",
            primaryButtonTitle: "확인",
            primaryAction: {
              viewStore.send(.tappedChangeLanguage)
            },
            secondaryButtonTitle: "취소",
            secondaryAction: {
              viewStore.send(.tappedCancel)
            })
        }
      }
    )
    .navigationBarBackButtonHidden(true)
  }
}
