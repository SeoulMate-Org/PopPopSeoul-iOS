//
//  CommonTopTabView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/19/25.
//

import SwiftUI

struct CommonTopTabView<T: Hashable>: View {
  let tabs: [T]
  let titleProvider: (T) -> String
  
  @Binding var selectedTab: T
  
  var body: some View {
    GeometryReader { geo in
      let tabWidth = (geo.size.width - 40) / CGFloat(tabs.count) // 좌우 패딩 포함 계산
      
      HStack(spacing: 0) {
        ForEach(tabs, id: \.self) { tab in
          Button(action: {
            selectedTab = tab
          }) {
            VStack(spacing: 0) {
              Spacer()
              Text(titleProvider(tab))
                .font(.bodyS)
                .foregroundColor(tab == selectedTab ? Colors.blue500.swiftUIColor : Colors.gray500.swiftUIColor)
                .frame(maxWidth: .infinity, alignment: .center)
              Spacer()
              Rectangle()
                .fill(tab == selectedTab ? Colors.blue500.swiftUIColor : .clear)
                .frame(height: 2)
            }
            .frame(width: tabWidth, height: 41)
          }
        }
      }
      .padding(.horizontal, 20)
    }
    .background(Colors.trueWhite.swiftUIColor)
    .frame(height: 41)
  }
}

#Preview {
  @Previewable @State var selectedTab: MyPopTab = .interest
  CommonTopTabView(
    tabs: MyPopTab.allCases,
    titleProvider: { $0.rawValue },
    selectedTab: $selectedTab
  )
}
