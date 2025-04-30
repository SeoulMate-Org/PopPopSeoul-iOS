//
//  AppLoginAlertView.swift
//  PopPopSeoul
//
//  Created by suni on 5/1/25.
//

import SwiftUI

public struct AppLoginAlertView: View {
  let onLoginTapped: () -> Void
  let onCancelTapped: () -> Void
  
  public init(onLoginTapped: @escaping () -> Void, onCancelTapped: @escaping () -> Void) {
    self.onLoginTapped = onLoginTapped
    self.onCancelTapped = onCancelTapped
  }
  
  public var body: some View {
    AppAlertView(
      title: "로그인이 필요해요",
      message: "해당 기능은 로그인 후 이용하실 수 있습니다.",
      primaryButtonTitle: "로그인",
      primaryAction: {
        onLoginTapped()
      },
      secondaryButtonTitle: "취소",
      secondaryAction: {
        onCancelTapped()
      })
  }
}

