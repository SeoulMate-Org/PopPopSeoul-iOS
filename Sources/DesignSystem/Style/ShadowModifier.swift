//
//  ShadowModifier.swift
//  SeoulMateKit
//
//  Created by suni on 4/4/25.
//

import SwiftUI

public struct AppShadow {
  var color: Color
  var x: CGFloat
  var y: CGFloat
  var blur: CGFloat
  var spread: CGFloat // SwiftUI는 지원하지 않음
  
  public init(color: Color, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
    self.color = color
    self.x = x
    self.y = y
    self.blur = blur
    self.spread = spread
  }
}

public struct ShadowModifier: ViewModifier {
  let shadow: AppShadow
  
  public init(shadow: AppShadow) {
    self.shadow = shadow
  }
  
  public func body(content: Content) -> some View {
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
  public func shadow(_ shadow: AppShadow) -> some View {
    self.modifier(ShadowModifier(shadow: shadow))
  }
}
