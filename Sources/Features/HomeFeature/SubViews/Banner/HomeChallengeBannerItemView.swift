//
//  HomeChallengeBannerItemView.swift
//  Clients
//
//  Created by suni on 4/23/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import Models

struct HomeChallengeBannerItemView: View {
  let challenge: MyChallenge
  let onLikeTapped: () -> Void
  let cardWidth: CGFloat
  let cardHeight: CGFloat
  var body: some View {
    
    ZStack(alignment: .bottom) {
      AsyncImage(url: URL(string: challenge.imageUrl)) { image in
        image
          .resizable()
          .scaledToFill()
      } placeholder: {
        Assets.Images.placeholderImage.swiftUIImage
          .resizable()
          .scaledToFill()
      }
      .frame(maxWidth: cardWidth, maxHeight: cardHeight)
      
      Rectangle()
        .fill(LinearGradient.blackFadeBottomToTop)
        .frame(width: cardWidth, height: 106)
      
      HStack(spacing: 8) {
        Text(challenge.name)
          .lineLimit(1)
          .font(.appTitle3)
          .foregroundColor(Colors.appWhite.swiftUIColor)
          .padding(.leading, 16)
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Button(action: onLikeTapped) {
          let image = challenge.isLiked ? Assets.Icons.heartFill : Assets.Icons.heartLine
          image.swiftUIImage
            .foregroundColor(challenge.isLiked ? Colors.red500.swiftUIColor : Colors.appWhite.swiftUIColor)
            .frame(width: 36, height: 36)
            .padding(.trailing, 10)
        }
      }
      .padding(.bottom, 10)
      .frame(width: cardWidth)
    }
    .frame(maxWidth: cardWidth, maxHeight: cardHeight)
    .cornerRadius(16)
  }
}

extension LinearGradient {
  static let blackFadeBottomToTop = LinearGradient(
    gradient: Gradient(stops: [
      .init(color: Color.hex(0x000000).opacity(1.0), location: 0.0),
      .init(color: Color.hex(0x000000).opacity(0.5), location: 0.5),
      .init(color: Color.hex(0x000000).opacity(0.0), location: 1.0)
    ]),
    startPoint: .bottom,
    endPoint: .top
  )
}
