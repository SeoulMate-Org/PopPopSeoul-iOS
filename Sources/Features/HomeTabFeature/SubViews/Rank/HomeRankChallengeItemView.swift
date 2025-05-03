//
//  HomeRankChallengeItemView.swift
//  DesignSystem
//
//  Created by suni on 4/29/25.
//

import SwiftUI
import Common
import SharedAssets
import SharedTypes
import Models
import Kingfisher
import DesignSystem

public struct HomeRankChallengeItemView: View {
  let rank: Int
  let challenge: Challenge
  let onLikeTapped: () -> Void
  
  public init(rank: Int, challenge: Challenge, onLikeTapped: @escaping () -> Void) {
    self.rank = rank
    self.challenge = challenge
    self.onLikeTapped = onLikeTapped
  }
  
  public var body: some View {
    HStack(alignment: .center, spacing: 0) {
      Text("\(rank)")
        .font(.smAggro(size: 18, weight: .medium))
        .foregroundColor(Colors.gray600.swiftUIColor)
        .frame(width: 18, alignment: .trailing)
      
      KFImage( URL(string: challenge.imageUrl))
        .placeholder {
          Assets.Images.placeholderImage.swiftUIImage
            .resizable()
            .scaledToFill()
        }.retry(maxCount: 2, interval: .seconds(5))
        .resizable()
        .scaledToFill()
        .frame(width: 56, height: 56)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.leading, 8)
    
      VStack(alignment: .leading, spacing: 4) {
        Text(challenge.name)
          .font(.bodyM)
          .foregroundColor(Color.hex(0x2B2B2B))
          .lineLimit(2)
        
        Text(L10n.homelistText_joined("\(challenge.progressCount)"))
          .font(.captionL)
          .foregroundColor(Colors.gray300.swiftUIColor)
      }
      .padding(.leading, 12)
      
      Spacer()
      
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
    .frame(maxWidth: .infinity)
    .padding(.vertical, 12)
    .padding(.horizontal, 8)
    .background(Colors.appWhite.swiftUIColor)
    .cornerRadius(20, corners: .allCorners)
    
  }
}
