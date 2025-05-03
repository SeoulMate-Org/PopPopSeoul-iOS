//
//  AppLoginAlertView.swift
//  PopPopSeoul
//
//  Created by suni on 5/1/25.
//

import SwiftUI
import Common

public struct AppLoginAlertView: View {
  let onLoginTapped: () -> Void
  let onCancelTapped: () -> Void
  
  public init(onLoginTapped: @escaping () -> Void, onCancelTapped: @escaping () -> Void) {
    self.onLoginTapped = onLoginTapped
    self.onCancelTapped = onCancelTapped
  }
  
  public var body: some View {
    AppAlertView(
      title: L10n.alertTitle_login,
      message: L10n.alertContent_login,
      primaryButtonTitle: L10n.textButton_login,
      primaryAction: {
        onLoginTapped()
      },
      secondaryButtonTitle: L10n.textButton_cancel,
      secondaryAction: {
        onCancelTapped()
      })
  }
}
