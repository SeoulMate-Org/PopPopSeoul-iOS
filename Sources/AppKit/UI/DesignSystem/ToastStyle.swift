//
//  ToastStyle.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/19/25.
//

import SwiftUI

struct AppToast: View {
  let type: AppToastType
  
  var body: some View {
    HStack(alignment: .center, spacing: 0) {
      HStack(alignment: .center, spacing: 0) {
        if case let .iconText(message, icon) = type {
          iconView(icon)
            .padding(.leading, 8)
          textView(message)
            .padding(.leading, 4)
            .padding(.trailing, 16)
        } else if case let .iconTextWithButton(message, icon, _, _) = type {
          iconView(icon)
            .padding(.leading, 8)
          textView(message)
            .padding(.leading, 4)
            .padding(.trailing, 16)
        } else {
          textOnlyView()
            .padding(.leading, 16)
            .padding(.trailing, 16)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      // Right Button
      if case let .textWithButton(_, title, onTap) = type {
        buttonView(title: title, action: onTap)
      } else if case let .iconTextWithButton(_, _, title, onTap) = type {
        buttonView(title: title, action: onTap)
      }
    }
    .padding(.vertical, 8)
    .padding(.trailing, 16)
    .frame(minHeight: 52)
    .background(Colors.gray600.swiftUIColor)
    .cornerRadius(15)
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 20)
  }
  
  @ViewBuilder
  private func iconView(_ icon: Image) -> some View {
    icon
      .resizable()
      .scaledToFit()
      .frame(width: 24, height: 24)
      .foregroundColor(Colors.appWhite.swiftUIColor)
      .frame(width: 36, height: 36)
  }
  
  @ViewBuilder
  private func textView(_ message: String) -> some View {
    Text(message)
      .font(.bodyS)
      .foregroundColor(Colors.appWhite.swiftUIColor)
      .multilineTextAlignment(.leading)
      .lineLimit(2)
  }
  
  @ViewBuilder
  private func buttonView(title: String, action: @escaping () -> Void) -> some View {
    Button(action: action) {
      Text(title)
        .font(.buttonS)
        .foregroundColor(Colors.appBlack.swiftUIColor)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
    .frame(height: 30)
    .background(Colors.gray50.swiftUIColor)
    .cornerRadius(10)
  }
  
  @ViewBuilder
  private func textOnlyView() -> some View {
    if case let .text(message) = type {
      textView(message)
    } else if case let .textWithButton(message, _, _) = type {
      textView(message)
    }
  }
}

#Preview {
  AppToast(type: .text(message: "Text"))
  AppToast(type: .textWithButton(message: "Toast Message", buttonTitle: "복구", onTap: { }))
  AppToast(type: .iconText(message: "Text"))
  AppToast(type: .iconTextWithButton(message: "Toast Message", buttonTitle: "복구", onTap: { }))
}

enum AppToastType {
  case text(message: String)
  case textWithButton(message: String, buttonTitle: String, onTap: () -> Void)
  case iconText(message: String, icon: Image = Assets.Icons.warningLine.swiftUIImage)
  case iconTextWithButton(message: String, icon: Image = Assets.Icons.warningLine.swiftUIImage, buttonTitle: String, onTap: () -> Void)
}
