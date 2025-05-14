//
//  KeyboardObserver.swift
//  Common
//
//  Created by suni on 4/27/25.
//

import Combine
import UIKit

public class KeyboardResponder: ObservableObject {
  private var notificationCenter: NotificationCenter
  @Published private(set) var currentHeight: CGFloat = 0
  
  public init(center: NotificationCenter = .default) {
    notificationCenter = center
    notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  deinit {
    notificationCenter.removeObserver(self)
  }
  
  @objc
  public func keyBoardWillShow(notification: Notification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      currentHeight = keyboardSize.height
    }
  }
  
  @objc
  public func keyBoardWillHide(notification: Notification) {
    currentHeight = 0
  }
}
