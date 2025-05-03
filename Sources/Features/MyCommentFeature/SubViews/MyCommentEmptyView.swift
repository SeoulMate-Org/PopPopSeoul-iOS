//
//  MyCommentEmptyView.swift
//  Features
//
//  Created by suni on 5/3/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import SharedTypes

struct MyCommentEmptyView: View {
  let onTapped: () -> Void
  
  var body: some View {
    VStack(spacing: 8) {
      Text(L10n.myCommentText_no)
        .font(.appTitle3)
        .foregroundColor(Colors.gray900.swiftUIColor)
      Text(L10n.myCommentSub_joinChallenge)
        .font(.bodyS)
        .foregroundColor(Colors.gray300.swiftUIColor)
      
      AppButton(title: L10n.textButton_browseChallenge, size: .msize, style: .primary, layout: .textOnly, state: .enabled, onTap: onTapped, isFullWidth: false)
        .frame(height: 38)
        .padding(.top, 20)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.clear)
  }
}
