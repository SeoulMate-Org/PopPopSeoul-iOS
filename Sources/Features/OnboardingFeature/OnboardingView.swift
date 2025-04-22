//
//  OnboardingView.swift
//  Clients
//
//  Created by suni on 4/22/25.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture
import Common

struct OnboardingView: View {
  let store: StoreOf<OnboardingFeature>
  
  init(store: StoreOf<OnboardingFeature>) {
    self.store = store
  }
  
    var body: some View {
      Button {
        store.send(.didFinish)
      } label: {
        Text("온보딩 닫기")
      }
    }
}
