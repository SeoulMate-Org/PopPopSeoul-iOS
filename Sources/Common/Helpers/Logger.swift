//
//  Logger.swift
//  SeoulMate
//
//  Created by suni on 3/31/25.
//

import Foundation
import Logging

let bundleID = Bundle.main.bundleIdentifier ?? "App"

public let logs: Logging.Logger = {
  return Logging.Logger(label: bundleID)
}()
