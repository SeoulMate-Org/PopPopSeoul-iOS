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
    HStack {
      themeTab
      mapTab
      likesTab
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
  
  var themeTab: some View {
    Button {
      store.send(.themeTapped)
    } label: {
      Assets.Icons.themeLine.swiftUIImage
    }
    .frame(width: 30, height: 30)
  }
  
  var mapTab: some View {
    Button {
      store.send(.mapTapped)
    } label: {
      Assets.Icons.mapLine.swiftUIImage
    }
    .frame(width: 30, height: 30)
  }
  
  var likesTab: some View {
    Button {
      store.send(.likesTapped)
    } label: {
      Assets.Icons.heartLine.swiftUIImage
    }
    .frame(width: 30, height: 30)
  }
}

// MARK: Preview

//#if DEBUG
//  struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//      MainTabView(
//        store: Store<MainTabFeature.State, MainTabFeature.Action>(
//          initialState: .init(),
//          reducer: { MainTabFeature() }
//        )
//      )
//    }
//  }
//#endif

#Preview {
  MainTabView(
    store: Store<MainTabFeature.State, MainTabFeature.Action>(
      initialState: .init(),
      reducer: { MainTabFeature() }
    )
  )
}

// MARK: - Helper
