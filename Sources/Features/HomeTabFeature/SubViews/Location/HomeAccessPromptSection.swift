//
//  HomeAccessPromptSection.swift
//  Clients
//
//  Created by suni on 4/23/25.
//

import SwiftUI
import DesignSystem
import Common
import SharedAssets

struct HomeAccessPromptSection: View {
  let type: PromptType
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 3) {
        Text(type.title)
          .lineLimit(2)
          .lineSpacing(11)
          .font(.buttonM)
          .foregroundColor(Colors.trueWhite.swiftUIColor)
          .frame(height: 54)
        
        if !type.description.isEmpty {
          Text(type.description)
            .lineLimit(2)
            .font(.captionM)
            .foregroundColor(Colors.trueWhite.swiftUIColor)
            .opacity(0.6)
        }
      }
      .padding(.leading, 16)
      
      Spacer()
      
      Assets.Images.homePrompt.swiftUIImage
        .resizable()
        .scaledToFit()
        .frame(width: 98, height: 98)
        .padding(.top, 3)
    }
    .frame(height: 100)
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(Color.hex(0x1D8EFE))
    )
    .padding(.horizontal, 20)
    .background(.clear)
  }
  
  enum PromptType {
    case login
    case location
    
    var title: String {
      switch self {
      case .login: return L10n.banner_signUp
      case .location: return L10n.banner_allowLocation
      }
    }
    
    var description: String {
      switch self {
      case .login: return L10n.banner_nearby
      case .location: return ""
      }
    }
  }
}
