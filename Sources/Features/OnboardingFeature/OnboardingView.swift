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
        // TODO: - Next
      } label: {
        Text("닫기")
      }
    }
}
