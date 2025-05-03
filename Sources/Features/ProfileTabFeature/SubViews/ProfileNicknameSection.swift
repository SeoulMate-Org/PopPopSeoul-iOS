//
//  ProfileNicknameSection.swift
//  Features
//
//  Created by suni on 5/2/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import SharedTypes
import Models

struct ProfileNicknameSection: View {
  let isLogin: Bool
  let user: User?
  let onTapped: () -> Void
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        if isLogin {
          Text(user?.nickname ?? "")
            .font(.appTitle1)
            .foregroundStyle(Colors.gray900.swiftUIColor)
        } else {
          Text(L10n.alertTitle_login)
            .font(.appTitle1)
            .foregroundStyle(Colors.gray900.swiftUIColor)
        }
        
        Spacer()
        
        Button(action: {
          onTapped()
        }) {
          Assets.Icons.arrowRightSmall.swiftUIImage
            .resizable()
            .frame(width: 24, height: 24)
        }
        .frame(width: 40, height: 40)
      }
      .frame(maxWidth: .infinity)
      .frame(height: 40)
      
      if let loginType = user?.appLoginType {
        if let logo = loginType.profileLogo {
          logo
            .resizable()
            .scaledToFit()
            .frame(height: 26)
            .padding(.top, 5)
        }
      } else if !isLogin {
        Text(L10n.mySubText_JJIMBadge)
          .font(.captionM)
          .foregroundColor(Colors.appWhite.swiftUIColor)
          .padding(.horizontal, 10)
          .padding(.vertical, 6)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .fill(Colors.blue400.swiftUIColor)
          )
          .padding(.top, 5)
      }
    }
    .padding(.top, 27)
    .padding(.bottom, 50)
    .padding(.horizontal, 20)
    .background(.clear)
  }
}

extension AppLoginType {
  var profileLogo: Image? {
    switch self {
    case .apple:
      Assets.Icons.appleProfile.swiftUIImage
    case .google:
      Assets.Icons.googleProfile.swiftUIImage
    case .facebook:
      Assets.Icons.facebookProfile.swiftUIImage
    case .none:
      nil
    }
  }
}
