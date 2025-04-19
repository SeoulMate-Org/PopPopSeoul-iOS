//
//  MyChallengeEmptyView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/18/25.
//

import SwiftUI

struct MyChallengeEmptyView: View {
  let tab: MyChallengeFeature.State.Tab
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
  MyChallengeEmptyView(tab: .interest, onTap: { })
}

// MARK: - Helper

extension MyChallengeFeature.State.Tab {
  var emptyTitle: String {
    switch self {
    case .interest: return String(sLocalization: .mychallengeInterestEmptyTitle)
    case .progress: return String(sLocalization: .mychallengeProgressEmptyTitle)
    case .completed: return String(sLocalization: .mychallengeCompletedEmptyTitle)
    }
  }
  
  var emptyText: String {
    switch self {
    case .interest: return String(sLocalization: .mychallengeInterestEmptyDes)
    case .progress: return String(sLocalization: .mychallengeProgressEmptyDes)
    case .completed: return String(sLocalization: .mychallengeCompletedEmptyDes)
    }
  }
  
  var buttonTitle: String? {
    switch self {
    case .interest: return String(sLocalization: .mychallengeInterestEmptyButton)
    case .progress: return String(sLocalization: .mychallengeProgressEmptyButton)
    case .completed: return nil
    }
  }
}
