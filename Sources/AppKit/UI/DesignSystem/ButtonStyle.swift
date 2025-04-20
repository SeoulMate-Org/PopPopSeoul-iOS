//
//  AppButton.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/18/25.
//

import SwiftUI
import Common

struct AppButton: View {
  let title: String
  let size: AppButtonSize
  let style: AppButtonStyleType
  let layout: AppButtonLayout
  let state: AppButtonState
  let onTap: () -> Void
  var isFullWidth: Bool = false

  var body: some View {
    Button(action: {
      if state == .enabled {
        onTap()
      }
    }, label: {
      EmptyView() // 실제 내용은 ButtonStyle이 렌더링함
    })
    .buttonStyle(AppButtonStyle(
      size: size,
      style: style,
      layout: layout,
      state: state,
      title: title,
      isFullWidth: isFullWidth
    ))
    .disabled(state == .disabled)
  }
}

// MARK: Preview

#Preview {
  AppButton(title: "버튼", size: .ssize, style: .neutral, layout: .textOnly, state: .enabled, onTap: {})
}

// MARK: - Helper

struct AppButtonStyle: ButtonStyle {
  let size: AppButtonSize
  let style: AppButtonStyleType
  let layout: AppButtonLayout
  let state: AppButtonState
  let title: String
  let isFullWidth: Bool

  func makeBody(configuration: Configuration) -> some View {
    let currentState: AppButtonState = {
      if state == .disabled {
        return .disabled
      } else if configuration.isPressed {
        return .pressed
      } else {
        return .enabled
      }
    }()

    return HStack(spacing: 6) {
      switch layout {
      case .textOnly:
        Text(title)
      case .textWithIcon(let icon):
        Text(title)
        icon
      case .iconOnly(let icon):
        icon
      }
    }
    .font(size.font)
    .foregroundColor(style.foregroundColor(for: currentState))
    .padding(.vertical, size.verticalPadding)
    .padding(.horizontal, size.horizontalPadding)
    .frame(maxHeight: .infinity)
    .if(isFullWidth) { view in
      view.frame(maxWidth: .infinity)
    }
    .background(style.backgroundColor(for: currentState))
    .overlay(
      RoundedRectangle(cornerRadius: 10)
        .stroke(style.borderColor(for: currentState) ?? .clear,
                lineWidth: style.borderColor(for: currentState) != nil ? 1.5 : 0)
    )
    .cornerRadius(10)
    .animation(nil, value: configuration.isPressed)
  }
}

enum AppButtonStyleType {
  case primary, outline, text, neutral
  
  var backgroundColor: Color {
    switch self {
    case .primary: return Colors.blue500.swiftUIColor
    case .outline, .text: return Colors.appWhite.swiftUIColor
    case .neutral: return Colors.gray50.swiftUIColor
    }
  }
  
  var borderColor: Color? {
    switch self {
    case .outline: return Colors.blue200.swiftUIColor
    default: return nil
    }
  }
  
  var foregroundColor: Color {
    switch self {
    case .primary: return Colors.appWhite.swiftUIColor
    case .outline, .text: return Colors.appBlack.swiftUIColor
    case .neutral: return Colors.appBlack.swiftUIColor
    }
  }
  
  func backgroundColor(for state: AppButtonState) -> Color {
    switch (self, state) {
    case (.primary, .enabled): return Colors.blue500.swiftUIColor
    case (.primary, .pressed): return Colors.blue600.swiftUIColor
    case (.primary, .disabled): return Colors.gray100.swiftUIColor
      
    case (.outline, .enabled): return Colors.appWhite.swiftUIColor
    case (.outline, .pressed): return Colors.opacityBlue10.swiftUIColor
    case (.outline, .disabled): return Colors.gray50.swiftUIColor
      
    case (.text, .enabled): return .clear
    case (.text, .pressed): return Colors.opacityBlue10.swiftUIColor
    case (.text, .disabled): return .clear
      
    case (.neutral, .enabled): return Colors.gray50.swiftUIColor
    case (.neutral, .pressed): return Colors.gray100.swiftUIColor
    case (.neutral, .disabled): return Colors.gray50.swiftUIColor
    }
  }
  
  func foregroundColor(for state: AppButtonState) -> Color {
    switch (self, state) {
    case (.primary, .enabled): return Colors.appWhite.swiftUIColor
    case (.primary, .pressed): return Colors.appWhite.swiftUIColor
    case (.primary, .disabled): return Colors.gray400.swiftUIColor
      
    case (.outline, .enabled): return Colors.blue500.swiftUIColor
    case (.outline, .pressed): return Colors.blue500.swiftUIColor
    case (.outline, .disabled): return Colors.gray300.swiftUIColor
      
    case (.text, .enabled): return Colors.blue500.swiftUIColor
    case (.text, .pressed): return Colors.blue500.swiftUIColor
    case (.text, .disabled): return Colors.gray300.swiftUIColor
      
    case (.neutral, .enabled): return Colors.appBlack.swiftUIColor
    case (.neutral, .pressed): return Colors.appBlack.swiftUIColor
    case (.neutral, .disabled): return Colors.gray300.swiftUIColor
    }
  }
  
  func borderColor(for state: AppButtonState) -> Color? {
    if self == .outline {
      switch state {
      case .enabled, .pressed: return Colors.blue200.swiftUIColor
      case .disabled: return Colors.gray200.swiftUIColor
      }
    }
    return nil
  }
}

enum AppButtonSize {
  case lsize, msize, ssize
  
  var font: Font {
    switch self {
    case .lsize, .msize: return .buttonM
    case .ssize: return .buttonS
    }
  }
  
  var verticalPadding: CGFloat {
    switch self {
    case .lsize: return 18.5
    case .msize: return 7
    case .ssize: return 9
    }
  }
  
  var horizontalPadding: CGFloat {
    switch self {
    case .lsize: return 38
    case .msize: return 20
    case .ssize: return 16
    }
  }
  
  var textHeight: CGFloat {
    switch self {
    case .lsize: return 19
    case .msize: return 24
    case .ssize: return 14
    }
  }
}

enum AppButtonState {
  case enabled
  case disabled
  case pressed
}

enum AppButtonLayout {
  case textOnly
  case textWithIcon(icon: Image = Assets.Icons.arrowRightLine.swiftUIImage)
  case iconOnly(icon: Image = Assets.Icons.arrowRightLine.swiftUIImage)
}
