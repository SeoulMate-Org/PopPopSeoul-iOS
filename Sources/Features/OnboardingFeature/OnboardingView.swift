//
//  OnboardingView.swift
//  Clients
//
//  Created by suni on 4/22/25.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import Common
import SharedTypes
import SharedAssets
import Clients

struct OnboardingView: View {
  let store: StoreOf<OnboardingFeature>
  @ObservedObject var viewStore: ViewStore<OnboardingFeature.State, OnboardingFeature.Action>
  
  init(store: StoreOf<OnboardingFeature>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  private let totalPages = 4
  
  var body: some View {
    let language = AppSettingManager.shared.language

    VStack(spacing: 0) {
      TabView(selection: viewStore.binding(
        get: \.currentPage,
        send: OnboardingFeature.Action.setCurrentPage
      )) {
        ForEach(0..<totalPages, id: \.self) { index in
          OnboardingPageView(index: index, language: language)
            .tag(index)
        }
      }
      .tabViewStyle(.page(indexDisplayMode: .never))
      .frame(maxHeight: .infinity) // ✅ 탑부터 최대한 확장

      indicator()
        .padding(.vertical, 24)
      
      nextButton()
        .padding(.vertical, 10)
    }
    .background(Colors.appWhite.swiftUIColor)
    .navigationBarBackButtonHidden()
  }
  
  @ViewBuilder
  private func indicator() -> some View {
    HStack(spacing: 6) {
      ForEach(0..<totalPages, id: \.self) { index in
        let isSelected = index == viewStore.currentPage
        Capsule()
          .fill(isSelected ? Colors.gray700.swiftUIColor : Colors.gray75.swiftUIColor)
          .frame(width: isSelected ? 16 : 8, height: 8)
      }
    }
    .padding(.bottom, 24)
  }
  
  @ViewBuilder
  private func nextButton() -> some View {
    let isLast = viewStore.currentPage == totalPages - 1

    Button(action: {
      viewStore.send(.tappedNext)
    }) {
      Text(isLast ? L10n.onboardingButton_start : L10n.onboardingButton_next)
        .font(.buttonM)
        .foregroundColor(Colors.appWhite.swiftUIColor)
        .frame(maxWidth: .infinity, minHeight: 51)
        .contentShape(Rectangle())
    }
    .buttonStyle(PlainButtonStyle())
    .background(Colors.blue500.swiftUIColor)
    .cornerRadius(15)
    .padding(.horizontal, 20)
  }
  
}
