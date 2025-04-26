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

public struct ThemeChallengeListItemView: View {
  let listType: ThemeChallengeListType
  let challenge: Challenge
  let onLikeTapped: () -> Void
  
  public init(listType: ThemeChallengeListType,
              challenge: Challenge, onLikeTapped:
              @escaping () -> Void) {
    self.listType = listType
    self.challenge = challenge
    self.onLikeTapped = onLikeTapped
  }
  
  public var body: some View {
    HStack(alignment: .center, spacing: 8) {
      AsyncImage(url: URL(string: challenge.imageURL)) { image in
        image
          .resizable()
          .scaledToFill()
      } placeholder: {
        Assets.Images.placeholderImage.swiftUIImage
          .resizable()
          .scaledToFill()
      }
      .frame(width: 76, height: 76)
      .clipShape(RoundedRectangle(cornerRadius: 16))
      
      VStack(alignment: .leading, spacing: 2) {
        Text(challenge.name)
          .font(.bodyM)
          .foregroundColor(Colors.gray900.swiftUIColor)
          .lineLimit(2)
        
        HStack(spacing: 10) {
          if challenge.likeCount > 0 {
            HStack(spacing: 2) {
              Assets.Icons.heartFill.swiftUIImage
                .resizable()
                .foregroundColor(Colors.gray100.swiftUIColor)
                .frame(width: 16, height: 16)
              
              Text("\(challenge.likeCount)")
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
          
          Text("\(challenge.mainLocal)")
            .font(.captionL)
            .foregroundColor(Colors.gray600.swiftUIColor)
        }
        .padding(.top, 6)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Button(action: {
        onLikeTapped()
      }) {
        Assets.Icons.heartFill.swiftUIImage
          .foregroundColor(.red)
          .frame(width: 19, height: 19)
      }
      .frame(width: 32, height: 32)
      .background(Colors.gray25.swiftUIColor)
      .cornerRadius(12)
      .padding(.leading, 8)
    }
    .background(.clear)
    .frame(height: 96)
  }
}
