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
      Text("아직 작성한 댓글이 없어요!")
        .font(.appTitle3)
        .foregroundColor(Colors.gray900.swiftUIColor)
      Text("챌린지에 참여하고 댓글을 달아보세요..")
        .font(.bodyS)
        .foregroundColor(Colors.gray300.swiftUIColor)
      
      AppButton(title: "챌린지 찾아보기", size: .msize, style: .primary, layout: .textOnly, state: .enabled, onTap: onTapped, isFullWidth: false)
        .frame(height: 38)
        .padding(.top, 20)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.clear)
  }
}
