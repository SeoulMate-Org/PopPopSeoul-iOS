//
//  HeaderView.swift
//  Common
//
//  Created by suni on 4/8/25.
//

import SwiftUI

struct HeaderView: View {
  let type: HeaderType
  
  var body: some View {
    HStack {
      switch type {
      case .titleOnly:
        Spacer()
        centerTitle
        Spacer()
        
      case .back(_, let onBack):
        Button(action: onBack) {
          Assets.Icons.arrowLeftLine.swiftUIImage
            .foregroundColor(Colors.gray900.swiftUIColor)
        }.frame(width: 50, height: 50)
        Spacer()
        centerTitle
        Spacer()
        Color.clear.frame(width: 40, height: 40)
      }
    }
    .padding(.horizontal, 8)
    .frame(height: 44)
    .background(Colors.trueWhite.swiftUIColor)
  }
  
  private var centerTitle: some View {
    switch type {
    case .titleOnly(let title),
        .back(let title, _):
      return Text(title)
        .font(.appTitle3)
        .foregroundColor(Colors.gray900.swiftUIColor)
    }
  }
}

// MARK: Preview

#Preview {
  HeaderView(type: .back(title: "Title", onBack: { }))
}

// MARK: - Helper

enum HeaderType {
  case titleOnly(title: String)
  case back(title: String, onBack: () -> Void)
}
