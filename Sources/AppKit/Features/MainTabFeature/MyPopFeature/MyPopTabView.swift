//
//  MyPopTabView.swift
//
//

import SwiftUI
import ComposableArchitecture
import Common

struct MyPopTabView: View {
  
  @State private var selectedTab: MyPopTab = .interest
  
  var body: some View {
    VStack(spacing: 0) {
      CommonHeaderView(
        type: .titleOnly(title: String(sLocalization: .mypopHeaderTitle))
      )
      
      CommonTopTabView(
        tabs: MyPopTab.allCases,
        titleProvider: { $0.title },
        selectedTab: $selectedTab
      )
      
      CommonEmptyView(
        image: Assets.Images.emptyPop.swiftUIImage,
        title: String(sLocalization: .mypopInterestEmptyTitle),
        text: String(sLocalization: .mypopInterestEmptyDes),
        buttonTitle: String(sLocalization: .mypopInterestEmptyButton),
        onTap: { }
      )
    }
  }
}

// MARK: Preview

#Preview {
  MyPopTabView()
}

// MARK: - Helper

enum MyPopTab: String, CaseIterable {

  case interest
  case progress
  case completed
  
  var title: String {
    switch self {
    case .interest: String(sLocalization: .mypopInterestTitle)
    case .progress: String(sLocalization: .mypopInprogressTitle)
    case .completed: String(sLocalization: .mypopCompletedTitle)
    }
  }
}
