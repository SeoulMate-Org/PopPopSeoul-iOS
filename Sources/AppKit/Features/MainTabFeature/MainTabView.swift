//
//  MainTabView.swift
//  SeoulMateKit
//
//  Created by suni on 4/2/25.
//

import SwiftUI
import ComposableArchitecture
import Common

public struct MainTabView: View {
  @Bindable var store: StoreOf<MainTabFeature>

  public init(store: StoreOf<MainTabFeature>) {
    self.store = store
  }

  public var body: some View {
    HStack {
      themeTab
      mapTab
      likesTab
    }
    .frame(height: 58)
    .background(Colors.black.swiftUIColor)
    .modifier(ShadowModifier())
  }

  var themeTab: some View {
    Button {
      store.send(.themeTapped)
    } label: {
      Image(systemName: "sparkles")
    }
    .frame(maxWidth: .infinity)
  }

  var mapTab: some View {
    Button {
      store.send(.mapTapped)
    } label: {
      Image(systemName: "map")
    }
    .frame(maxWidth: .infinity)
  }

  var likesTab: some View {
    Button {
      store.send(.likesTapped)
    } label: {
      Image(systemName: "heart")
    }
    .frame(maxWidth: .infinity)
  }
}

// MARK: Preview

#Preview {
  MainTabView(
    store: Store<MainTabFeature.State, MainTabFeature.Action>(
      initialState: .init(),
      reducer: { MainTabFeature() }
    )
  )
}

// MARK: - Helper

struct ShadowModifier: ViewModifier {
  @Environment(\.colorScheme) var colorScheme

  func body(content: Content) -> some View {
    Group {
      if colorScheme == .light {
        content
          .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0.0, y: 0.0)
      } else {
        content
      }
    }
  }
}
