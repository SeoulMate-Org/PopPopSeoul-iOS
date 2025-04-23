//
//  StatefulPreviewWrapper.swift
//  Clients
//
//  Created by suni on 4/24/25.
//

import SwiftUI

public struct StatefulPreviewWrapper<Value: Equatable, Content: View>: View {
  @State public var value: Value
  public var content: (Binding<Value>) -> Content

  public init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
    _value = State(initialValue: value)
    self.content = content
  }

  public var body: some View {
    content($value)
  }
}
