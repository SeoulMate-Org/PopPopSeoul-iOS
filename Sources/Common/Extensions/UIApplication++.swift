//
//  UIApplication++.swift
//  PopPopSeoul
//
//  Created by suni on 4/21/25.
//

import UIKit

extension UIApplication {
  public var firstKeyWindow: UIWindow? {
    self.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first { $0.isKeyWindow }
  }
}
