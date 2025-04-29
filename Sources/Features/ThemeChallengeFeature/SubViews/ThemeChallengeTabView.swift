//
//  ThemeChallengeTabView.swift
//  Features
//
//  Created by suni on 4/29/25.
//

import SwiftUI
import Common
import DesignSystem
import Clients
import SharedAssets
import SharedTypes
import Models

struct ThemeChallengeTabView: View {
  @Binding var selectedTab: ChallengeTheme
  let themeTabChanged: (ChallengeTheme) -> Void
  
  var body: some View {
    let lanuage = AppSettingManager.shared.language
    
    ScrollViewReader { proxy in
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 8) {
          ForEach(ChallengeTheme.sortedByPriority(), id: \.self) { tab in
            Button(action: {
              selectedTab = tab
            }) {
              VStack(spacing: 0) {
                Text(tab.title(lanuage))
                  .font(.bodyS)
                  .foregroundColor(tab == selectedTab ? Colors.blue500.swiftUIColor : Colors.gray500.swiftUIColor)
                  .frame(alignment: .center)
                  .padding(.horizontal, 10)
                  .padding(.top, 12)
                  .padding(.bottom, 10)
                Rectangle()
                  .fill(tab == selectedTab ? Colors.blue500.swiftUIColor : .clear)
                  .frame(height: 2)
              }
              .frame(height: 41)
            }
          }
        }
        .padding(.horizontal, 16)
      }
      .padding(.top, 16)
      .onChange(of: selectedTab, initial: false) { oldTab, newTab in
        guard oldTab != newTab else { return }
        withAnimation {
          proxy.scrollTo(newTab, anchor: .center)
        }
      }
    }
  }
}
