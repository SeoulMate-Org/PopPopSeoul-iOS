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
          case .home:
            HomeTabView()
          case .myPop:
            MyPopTabView(
              store: store.scope(
                state: \.myPop,
                action: \.myPop
              )
            )
          case .profile:
            ProfileTabView()
          }
        }
        .frame(maxHeight: .infinity)
        
        VStack(spacing: 0) {
          Rectangle()
            .foregroundColor(Colors.gray25.swiftUIColor)
            .frame(height: 1)
          
          HStack {
            tabItem(tab: .home, isSelected: viewStore.state == .home) {
              store.send(.selectedTabChanged(.home))
            }
            
            tabItem(tab: .myPop, isSelected: viewStore.state == .myPop) {
              store.send(.selectedTabChanged(.myPop))
            }
            
            tabItem(tab: .profile, isSelected: viewStore.state == .profile) {
              store.send(.selectedTabChanged(.profile))
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
            .font(.pretendard(size: 12, weight: .semibold))
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
    case .home: String(sLocalization: .tabHome)
    case .myPop: String(sLocalization: .tabMychallenge)
    case .profile: String(sLocalization: .tabProfile)
    }
  }
  
  var icon: Image {
    switch self {
    case .home: Assets.Icons.homeLine.swiftUIImage
    case .myPop: Assets.Icons.popLine.swiftUIImage
    case .profile: Assets.Icons.profileLine.swiftUIImage
    }
  }
  
  var selectedIcon: Image {
    switch self {
    case .home: Assets.Icons.homeFill.swiftUIImage
    case .myPop: Assets.Icons.popFill.swiftUIImage
    case .profile: Assets.Icons.profileLine.swiftUIImage
    }
  }
}
