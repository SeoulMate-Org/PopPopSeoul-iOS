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
  @State private var store: StoreOf<MainTabFeature>
  
  public init(store: StoreOf<MainTabFeature>) {
    self.store = store
  }

  public var body: some View {
    VStack {
      Spacer()
      HStack {
        Spacer(minLength: 20)
        
        tabItem(icon: Assets.Icons.themeLine.swiftUIImage, label: "테마추천") {
          store.send(.themeTapped)
        }
        
        tabItem(icon: Assets.Icons.mapLine.swiftUIImage, label: "지도") {
          store.send(.mapTapped)
        }
        
        tabItem(icon: Assets.Icons.heartLine.swiftUIImage, label: "좋아요") {
          store.send(.likesTapped)
        }
      }
      .frame(height: 58)
      .background(Colors.white.swiftUIColor)
      .modifier(ShadowModifier(
        shadow: AppShadow(
          color: Colors.trueBlack.swiftUIColor.opacity(0.08),
          x: 0,
          y: -4,
          blur: 12,
          spread: 0
        )
      ))
    }
  }
  
  @ViewBuilder
  func tabItem(icon: Image, label: String, action: @escaping () -> Void) -> some View {
    VStack {
      Button(action: action) {
        VStack(spacing: 4) {
          icon
            .resizable()
            .frame(width: 24, height: 24)

          Text(label)
            .font(.system(size: 12))
            .foregroundColor(.black)
        }
      }
      .buttonStyle(PlainButtonStyle())
      .contentShape(Rectangle())
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
