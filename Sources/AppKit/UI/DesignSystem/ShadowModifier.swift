//
//  ShadowModifier.swift
//  SeoulMateKit
//
//  Created by suni on 4/4/25.
//

import SwiftUI

struct AppShadow {
    var color: Color
    var x: CGFloat
    var y: CGFloat
    var blur: CGFloat
    var spread: CGFloat // SwiftUI는 지원하지 않음
}

struct ShadowModifier: ViewModifier {
  let shadow: AppShadow

  func body(content: Content) -> some View {
      content
          .shadow(
              color: shadow.color,
              radius: shadow.blur / 2, // Figma는 Gaussian blur radius, SwiftUI는 standard blur radius
              x: shadow.x,
              y: shadow.y
          )
  }
}

extension View {
    func shadow(_ shadow: AppShadow) -> some View {
        self.modifier(ShadowModifier(shadow: shadow))
    }
}
