//
//  LoginButtonView.swift
//  Clients
//
//  Created by suni on 4/24/25.
//

import SwiftUI
import SharedAssets
import Common
import DesignSystem

struct LoginButtonView: View {
  let image: Image
  let text: String
  let onTap: (() -> Void)?
  let isLight: Bool
  
  init(image: Image, text: String, onTap: (() -> Void)?, isLight: Bool) {
    self.image = image
    self.text = text
    self.onTap = onTap
    self.isLight = isLight
  }
  
  var body: some View {
    Button(action: { onTap?() }) {
      HStack(alignment: .center, spacing: 20) {
        image
          .resizable()
          .frame(width: 24, height: 24)
          .padding(.leading, 15)
        
        Text(text)
          .lineLimit(1)
          .font(.buttonM)
          .foregroundColor(isLight ? Color.hex(0xFFFFFF) : Color.hex(0x1F1F1F))
          .padding(.trailing, 15)
        
        Spacer()
      }
      .frame(maxWidth: .infinity)
      .frame(height: 52)
      .background(isLight ? Color.hex(0x1F1F1F) : Color.hex(0xFFFFFF))
      .cornerRadius(8)
      .padding(.horizontal, 35)
    }
  }
}

#Preview {
  LoginButtonView(
    image: Assets.Icons.facebook.swiftUIImage,
    text: "페이스북으로 계속하기",
    onTap: { }, isLight: true
  )
}
