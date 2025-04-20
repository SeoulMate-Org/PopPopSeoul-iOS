//
//  HeaderView.swift
//  Common
//
//  Created by suni on 4/8/25.
//

import SwiftUI
import Common

public struct HeaderView: View {
  let type: HeaderType
  
  public init(type: HeaderType) {
    self.type = type
  }
  
  public var body: some View {
    HStack {
      switch type {
      case .titleOnly:
        Spacer()
        centerTitle
        Spacer()
        
      case .back(_, let onBack),
          .backWithMenu(_, let onBack, _):
        Button(action: onBack) {
          Assets.Icons.arrowLeftLine.swiftUIImage
            .foregroundColor(Colors.gray900.swiftUIColor)
        }.frame(width: 50, height: 50)
        Spacer()
        centerTitle
        Spacer()
        
        if case .backWithMenu(_, _, let onMore) = type {
          Button(action: { onMore() }) {
            Assets.Icons.more.swiftUIImage
              .foregroundColor(Colors.gray900.swiftUIColor)
          }
          .frame(width: 44, height: 44)
        } else {
          Color.clear.frame(width: 40, height: 40)
        }
      }
    }
    .padding(.horizontal, 8)
    .frame(height: 44)
    .background(Colors.trueWhite.swiftUIColor)
  }
  
  private var centerTitle: some View {
    switch type {
    case .titleOnly(let title),
        .back(let title, _),
        .backWithMenu(let title, _, _):
      return Text(title)
        .font(.appTitle3)
        .foregroundColor(Colors.gray900.swiftUIColor)
    }
  }
}

// MARK: Preview

#Preview {
  HeaderView(type: .backWithMenu(title: "", onBack: { }, onMore: { }))
}

// MARK: - Helper

public enum HeaderType {
  case titleOnly(title: String)
  case back(title: String, onBack: () -> Void)
  case backWithMenu(title: String, onBack: () -> Void, onMore: () -> Void)
}
