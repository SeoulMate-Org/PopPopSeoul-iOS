//
//  Haptic.swift
//  Common
//
//  Created by suni on 5/1/25.
//

import UIKit

public enum Haptic {
  public static func success() {
    UINotificationFeedbackGenerator().notificationOccurred(.success)
  }

  public static func lightImpact() {
    UIImpactFeedbackGenerator(style: .light).impactOccurred()
  }

  public static func selection() {
    UISelectionFeedbackGenerator().selectionChanged()
  }
}
