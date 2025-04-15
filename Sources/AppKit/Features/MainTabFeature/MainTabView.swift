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
    WithViewStore(store, observe: \.selectedTab) { viewStore in
      VStack(spacing: 0) {
        Group {
          switch viewStore.state {
          case .theme:
            Spacer()
          case .map:
            Spacer()
          case .likes:
            Spacer()
          }
        }
        .frame(maxHeight: .infinity)
        
        VStack(spacing: 0) {
          Rectangle()
            .foregroundColor(Colors.gray25.swiftUIColor)
            .frame(height: 1)
          
          HStack {
            tabItem(tab: .theme, isSelected: viewStore.state == .theme) {
              store.send(.themeTapped)
            }
            
            tabItem(tab: .map, isSelected: viewStore.state == .map) {
              store.send(.mapTapped)
            }
            
            tabItem(tab: .likes, isSelected: viewStore.state == .likes) {
              store.send(.likesTapped)
            }
          }
          .frame(height: 58)
          .background(Color(Colors.appWhite.swiftUIColor))
          .contentMargins(.horizontal, 20)
        }
        .modifier(ShadowModifier(
          shadow: AppShadow(
            color: Color(Colors.trueBlack.swiftUIColor).opacity(0.08),
            x: 0,
            y: -4,
            blur: 12,
            spread: 0
          )
        ))
      }
    }
  }
  
  @ViewBuilder
  func tabItem(tab: MainTabFeature.State.Tab, isSelected: Bool, action: @escaping () -> Void) -> some View {
    
    let icon = isSelected ? tab.selectedIcon : tab.icon
    let label = tab.title
    let color = isSelected ? tab.selectedColor : tab.color
    
    VStack {
      Button(action: action) {
        VStack(spacing: 4) {
          icon
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(color)
          
          Text(label)
            .font(Fonts.Pretendard.semiBold.swiftUIFont(size: 12))
            .foregroundColor(color)
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

extension MainTabFeature.State.Tab {
  var color: Color {
    Color(Colors.gray300.swiftUIColor)
  }

  var selectedColor: Color {
    Color(Colors.blue500.swiftUIColor)
  }
  
  var title: String {
    switch self {
    case .theme: "tab_theme".localized
    case .map: "tab_map".localized
    case .likes: "tab_like".localized
    }
  }
  
  var icon: Image {
    switch self {
    case .theme: Assets.Icons.themeLine.swiftUIImage
    case .map: Assets.Icons.mapLine.swiftUIImage
    case .likes: Assets.Icons.heartLine.swiftUIImage
    }
  }
  
  var selectedIcon: Image {
    switch self {
    case .theme: Assets.Icons.themeFill.swiftUIImage
    case .map: Assets.Icons.mapFill.swiftUIImage
    case .likes: Assets.Icons.heartFill.swiftUIImage
    }
  }
}
