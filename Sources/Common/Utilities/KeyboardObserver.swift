//
//  KeyboardObserver.swift
//  Common
//
//  Created by suni on 4/27/25.
//

import Combine
import UIKit

public class KeyboardObserver: ObservableObject {
  @Published public var height: CGFloat = 0
  public var cancellables = Set<AnyCancellable>()

  public init() {
    NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
      .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
      .map { $0.height }
      .assign(to: \.height, on: self)
      .store(in: &cancellables)

    NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
      .map { _ in CGFloat(0) }
      .assign(to: \.height, on: self)
      .store(in: &cancellables)
  }
}
