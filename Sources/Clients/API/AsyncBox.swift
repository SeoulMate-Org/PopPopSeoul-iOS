//
//  AsyncBox.swift
//  Common
//
//  Created by suni on 4/26/25.
//

import Foundation

actor AsyncBox<Value> {
  private(set) var value: Value

  init(value: Value) {
    self.value = value
  }

  func set(_ newValue: Value) {
    self.value = newValue
  }
}
