//
//  CommonEmptyView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/18/25.
//

import SwiftUI

struct CommonEmptyView: View {
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
        Text(title)
          .font(.bodyS)
          .foregroundColor(Colors.gray300.swiftUIColor)
      }

      Button(action: onTap) {
        Text(buttonTitle)
          .multilineTextAlignment(.center)
          .padding(.vertical, 7)
          .padding(.horizontal, 20)
          .background(Colors.blue500.swiftUIColor)
          .foregroundColor(Colors.appWhite.swiftUIColor)
          .cornerRadius(8)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.clear)
  }
}

#Preview {
  CommonEmptyView(title: "title", text: "text", buttonTitle: "button", onTap: {})
}
