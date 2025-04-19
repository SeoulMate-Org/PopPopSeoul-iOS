//
//  MyPopEmptyView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/18/25.
//

import SwiftUI

struct MyPopEmptyView: View {
  var image: Image = Assets.Images.emptyPop.swiftUIImage
  let title: String
  let text: String
  let buttonTitle: String
  let onTap: () -> Void

  var body: some View {
    VStack(spacing: 28) {
      image
        .resizable()
        .scaledToFit()
        .frame(width: 100, height: 100)
      VStack(spacing: 8) {
        Text(title)
          .font(.appTitle3)
          .foregroundColor(Colors.gray900.swiftUIColor)
        Text(text)
          .font(.bodyS)
          .foregroundColor(Colors.gray300.swiftUIColor)
      }
      
      AppButton(title: buttonTitle, size: .msize, style: .primary, layout: .textOnly, state: .enabled, onTap: onTap)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.clear)
  }
}

#Preview {
  MyPopEmptyView(title: "title", text: "text", buttonTitle: "button", onTap: {})
}
