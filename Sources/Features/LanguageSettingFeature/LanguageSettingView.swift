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
      HeaderView(type: .back(title: L10n.myListText_language, onBack: {
        viewStore.send(.tappedBack)
      }))
      
      VStack(alignment: .leading, spacing: 12) {
        Text(L10n.detaillanguageTitle)
          .font(.appTitle3)
          .foregroundStyle(Colors.gray900.swiftUIColor)
        
        LanguageRow(
          title: L10n.korean,
          isSelected: viewStore.language == .kor,
          onTap: { viewStore.send(.tappedLanguage(.kor)) }
        )
        
        LanguageRow(
          title: L10n.english,
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
            title: L10n.buttonText_changeLanguage,
            message: L10n.buttonText_refresh,
            primaryButtonTitle: L10n.textButton_ok,
            primaryAction: {
              viewStore.send(.tappedChangeLanguage)
            },
            secondaryButtonTitle: L10n.textButton_cancel,
            secondaryAction: {
              viewStore.send(.tappedCancel)
            })
        }
      }
    )
    .navigationBarBackButtonHidden(true)
  }
}
