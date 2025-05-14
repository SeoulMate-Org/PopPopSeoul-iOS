//
//  AppAlertView.swift
//  DesignSystem
//
//  Created by suni on 4/27/25.
//

import SwiftUI
import SharedAssets

public struct AppAlertView: View {
  let title: String
  let message: String
  let primaryButtonTitle: String
  let primaryAction: () -> Void
  let secondaryButtonTitle: String?
  let secondaryAction: (() -> Void)?
  
  public init(title: String, message: String, primaryButtonTitle: String, primaryAction: @escaping () -> Void, secondaryButtonTitle: String?, secondaryAction: (() -> Void)?) {
    self.title = title
    self.message = message
    self.primaryButtonTitle = primaryButtonTitle
    self.primaryAction = primaryAction
    self.secondaryButtonTitle = secondaryButtonTitle
    self.secondaryAction = secondaryAction
  }

  public var body: some View {
    ZStack {
      Colors.opacityBlack40.swiftUIColor
        .ignoresSafeArea()

      VStack(alignment: .leading, spacing: 8) {
        Text(title)
          .font(.appTitle2)
          .foregroundColor(Colors.gray900.swiftUIColor)

        Text(message)
          .font(.bodyM)
          .foregroundColor(Colors.gray600.swiftUIColor)

        HStack(spacing: 12) {
          if let secondaryTitle = secondaryButtonTitle, let secondaryAction = secondaryAction {
            Button(action: secondaryAction) {
              Text(secondaryTitle)
                .font(.buttonM)
                .foregroundColor(Colors.appBlack.swiftUIColor)
                .frame(maxWidth: .infinity)
                .padding(16)
                .background(Colors.gray50.swiftUIColor)
                .cornerRadius(16)
            }
          }

          Button(action: primaryAction) {
            Text(primaryButtonTitle)
              .font(.buttonM)
              .foregroundColor(Colors.appWhite.swiftUIColor)
              .frame(maxWidth: .infinity)
              .padding(16)
              .background(Colors.blue500.swiftUIColor)
              .cornerRadius(16)
          }
        }
        .padding(.top, 8)
      }
      .padding(20)
      .background(Colors.appWhite.swiftUIColor)
      .cornerRadius(20)
      .padding(.horizontal, 27.5)
    }
  }
}

// MARK: - Preview
