//
//  SplashView.swift
//  Clients
//
//  Created by suni on 4/22/25.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

struct SplashView: View {
  let store: StoreOf<SplashFeature>
  
  init(store: StoreOf<SplashFeature>) {
    self.store = store
  }
  
  var body: some View {
    ZStack {
      Assets.Images.splash.swiftUIImage
        .resizable()
        .scaledToFill()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
        .ignoresSafeArea()
        .accessibilityHidden(true)
    }.alert(
      store: store.scope(state: \.$alert, action: \.alert)
    )
    .onAppear {
      store.send(.onAppear)
    }
  }
}

#Preview {
  SplashView(
    store: Store<SplashFeature.State, SplashFeature.Action>(
      initialState: .init(),
      reducer: { SplashFeature() }
    )
  )
}
