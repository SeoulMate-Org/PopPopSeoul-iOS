//
//  EventChallengeDateView.swift
//  Features
//
//  Created by suni on 5/3/25.
//

import SwiftUI
import Common
import SharedAssets
import SharedTypes
import Models
import DesignSystem

struct EventChallengeDateView: View {
  let start: String
  let end: String
  
  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      
      Assets.Icons.timeLine.swiftUIImage
        .resizable()
        .frame(width: 18, height: 18)
        .foregroundStyle(Colors.gray400.swiftUIColor)
        .padding(.top, 8)
      
      Text("\(start) ~ \(end)")
        .font(.bodyS)
        .foregroundStyle(Colors.gray900.swiftUIColor)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
    }
  }
}
