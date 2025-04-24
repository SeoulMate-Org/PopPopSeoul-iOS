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
        }
      }
      .padding(.leading, 16)
      
      Spacer()
      
      if type == .login {
        type.image
          .frame(width: 98, height: 98)
          .padding(.top, 3)
      } else {
        type.image
          .frame(width: 75, height: 92)
          .padding(.top, 0)
          .padding(.trailing, 16)
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(Color.hex(0x1D8EFE))
    )
    .frame(height: 100)
    .padding(.horizontal, 20)
  }
  
  enum PromptType {
    case login
    case location
    
    var title: String {
      switch self {
      case .login: return "지금 가입하고\n가까운 챌린지를 참여해봐요!"
      case .location: return "근처 챌린지를 찾으려면\n위치 권한이 필요해요"
      }
    }
    
    var description: String {
      switch self {
      case .login: return "근처 장소부터 쉽게 참여할 수 있어요"
      case .location: return ""
      }
    }
    
    var image: Image {
      switch self {
      case .login:
        return Assets.Images.homePromptLogin.swiftUIImage
      case .location:
        return Assets.Images.homePromptLocation.swiftUIImage
      }
    }
  }
}

//#Preview {
//  HomeAccessPromptSection(type: .login)
//}
