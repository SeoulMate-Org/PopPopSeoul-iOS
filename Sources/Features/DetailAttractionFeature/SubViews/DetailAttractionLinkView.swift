//
//  DetailAttractionLinkView.swift
//  Features
//
//  Created by suni on 4/30/25.
//

import SwiftUI
import Common
import SharedAssets
import SharedTypes
import Models
import DesignSystem

struct DetailAttractionLinkView: View {
  let text: String
  let link: URL
  
  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      
      Assets.Icons.webLine.swiftUIImage
        .resizable()
        .frame(width: 18, height: 18)
        .foregroundStyle(Colors.gray400.swiftUIColor)
        .padding(.top, 8)
      
      Link(text, destination: link)
        .lineLimit(1)
        .multilineTextAlignment(.leading)
        .font(.bodyS)
        .foregroundStyle(Colors.blue300.swiftUIColor)
        .underline()
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
    }
  }
}
