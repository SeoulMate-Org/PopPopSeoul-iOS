//
//  ThemeChallengeListItemView.swift
//  DesignSystem
//
//  Created by suni on 4/24/25.
//

import SwiftUI
import Common
import SharedAssets
import SharedTypes
import Models
import Kingfisher

public struct ThemeChallengeListItemView: View {
  let listType: ThemeChallengeListType
  let challenge: MyChallenge
  let onLikeTapped: () -> Void
  
  public init(listType: ThemeChallengeListType,
              challenge: MyChallenge, onLikeTapped:
              @escaping () -> Void) {
    self.listType = listType
    self.challenge = challenge
    self.onLikeTapped = onLikeTapped
  }
  
  public var body: some View {
    HStack(alignment: .center, spacing: 8) {
      KFImage( URL(string: challenge.imageUrl))
        .placeholder {
          Assets.Images.placeholderImage.swiftUIImage
        }.retry(maxCount: 2, interval: .seconds(5))
        .resizable()
        .scaledToFill()
        .frame(width: 76, height: 76)
        .clipShape(RoundedRectangle(cornerRadius: 16))
      
      VStack(alignment: .leading, spacing: 2) {
        Text(challenge.name)
          .font(.bodyM)
          .foregroundColor(Colors.gray900.swiftUIColor)
          .lineLimit(2)
        
        HStack(spacing: 10) {
          if challenge.likes > 0 {
            HStack(spacing: 2) {
              Assets.Icons.heartFill.swiftUIImage
                .resizable()
                .foregroundColor(Colors.gray100.swiftUIColor)
                .frame(width: 16, height: 16)
              
              Text("\(challenge.likes)")
                .font(.captionL)
                .foregroundColor(Colors.gray300.swiftUIColor)
            }
          }
          
          if challenge.commentCount > 0 {
            HStack(spacing: 2) {
              Assets.Icons.commentFill.swiftUIImage
                .resizable()
                .foregroundColor(Colors.gray100.swiftUIColor)
                .frame(width: 16, height: 16)
              
              Text("\(challenge.commentCount)")
                .font(.captionL)
                .foregroundColor(Colors.gray300.swiftUIColor)
            }
          }
        }
        
        HStack(spacing: 4) {
          Text("주요 동네")
            .font(.captionM)
            .foregroundColor(Colors.blue500.swiftUIColor)
            .padding(.horizontal, 4)
            .padding(.vertical, 1)
            .background(
              RoundedRectangle(cornerRadius: 4)
                .fill(Colors.blue50.swiftUIColor)
            )
          
          Text("\(challenge.mainLocation)")
            .font(.captionL)
            .foregroundColor(Colors.gray600.swiftUIColor)
        }
        .padding(.top, 6)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Button(action: {
        onLikeTapped()
      }) {
        let image = challenge.isLiked ? Assets.Icons.heartFill.swiftUIImage : Assets.Icons.heartLine.swiftUIImage
        image
          .resizable()
          .foregroundColor(challenge.isLiked ? Colors.red500.swiftUIColor : Colors.gray300.swiftUIColor)
          .frame(width: 24, height: 24)
      }
      .frame(width: 40, height: 40)
      .background(Colors.gray25.swiftUIColor)
      .cornerRadius(16)
      .padding(.leading, 8)
    }
    .background(.clear)
    .frame(height: 92)
  }
}
