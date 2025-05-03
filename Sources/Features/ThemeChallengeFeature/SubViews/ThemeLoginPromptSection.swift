//
//  ThemeLoginPromptSection.swift
//  Features
//
//  Created by suni on 4/29/25.
//

import SwiftUI
import DesignSystem
import Common
import SharedAssets

struct ThemeLoginPromptSection: View {
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 3) {
        Text(L10n.banner_signIn)
          .lineLimit(2)
          .lineSpacing(11)
          .font(.buttonM)
          .foregroundColor(Colors.trueWhite.swiftUIColor)
          .frame(height: 54)
        
        Text(L10n.banner_collectStamp)
            .lineLimit(2)
            .font(.captionM)
            .foregroundColor(Colors.trueWhite.swiftUIColor)
            .opacity(0.6)
      }
      .padding(.leading, 16)
      
      Spacer()
      
      Assets.Images.themePromptLogin.swiftUIImage
        .resizable()
        .scaledToFit()
        .frame(width: 88, height: 88)
        .padding(.top, 2)
    }
    .frame(height: 100)
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(Color.hex(0x1D8EFE))
    )
    .padding(.horizontal, 20)
    .background(.clear)
  }
}
