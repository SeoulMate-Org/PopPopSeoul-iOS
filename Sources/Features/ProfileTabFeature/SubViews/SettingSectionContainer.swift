//
//  SettingSectionContainer.swift
//  Features
//
//  Created by suni on 5/2/25.
//

import SwiftUI
import SharedAssets

struct SettingSectionContainer<Content: View>: View {
  let content: () -> Content
  
  init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content
  }

  var body: some View {
    VStack(spacing: 4, content: content)
      .padding(.vertical, 8)
      .frame(maxWidth: .infinity)
      .background(
        RoundedRectangle(cornerRadius: 16)
          .fill(Colors.appWhite.swiftUIColor)
      )
      .padding(.horizontal, 20)
  }
}
