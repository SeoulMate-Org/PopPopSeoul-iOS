//
//  MyPopEmptyView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/18/25.
//

import SwiftUI

struct MyPopEmptyView: View {
  let tab: MyPopFeature.State.Tab
  let image: Image = Assets.Images.emptyPop.swiftUIImage
  let onTap: () -> Void

  var body: some View {
    VStack(spacing: 28) {
      image
        .resizable()
        .scaledToFit()
        .frame(width: 100, height: 100)
      VStack(spacing: 8) {
        Text(tab.emptyTitle)
          .font(.appTitle3)
          .foregroundColor(Colors.gray900.swiftUIColor)
        Text(tab.emptyText)
          .font(.bodyS)
          .foregroundColor(Colors.gray300.swiftUIColor)
      }
      
      if let buttonTitle = tab.buttonTitle {
        AppButton(title: buttonTitle, size: .msize, style: .primary, layout: .textOnly, state: .enabled, onTap: onTap)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.clear)
  }
}

// MARK: Preview

#Preview {
  MyPopEmptyView(tab: .interest, onTap: { })
}

// MARK: - Helper

extension MyPopFeature.State.Tab {
  var emptyTitle: String {
    switch self {
    case .interest: return String(sLocalization: .mypopInterestEmptyTitle)
    case .progress: return String(sLocalization: .mypopProgressEmptyTitle)
    case .completed: return String(sLocalization: .mypopCompletedEmptyTitle)
    }
  }
  
  var emptyText: String {
    switch self {
    case .interest: return String(sLocalization: .mypopInterestEmptyDes)
    case .progress: return String(sLocalization: .mypopProgressEmptyDes)
    case .completed: return String(sLocalization: .mypopCompletedEmptyDes)
    }
  }
  
  var buttonTitle: String? {
    switch self {
    case .interest: return String(sLocalization: .mypopInterestEmptyButton)
    case .progress: return String(sLocalization: .mypopProgressEmptyButton)
    case .completed: return nil
    }
  }
}
