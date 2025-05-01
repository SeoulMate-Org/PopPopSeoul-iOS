//
//  EventChallengeImageView.swift
//  Features
//
//  Created by suni on 5/1/25.
//

import SwiftUI
import Kingfisher
import Common
import SharedAssets

struct EventChallengeImageView: View {
  let imageURL: URL?
  
  @State private var image: UIImage? = nil
  @State private var isPortrait: Bool? = nil
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        if let image = image {
          // 1. 배경 이미지 + 블러
          Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 280 / 375)
            .clipped()
            .blur(radius: 35)
          
          // 2. 메인 이미지
          if let isPortrait = isPortrait {
            if isPortrait {
              Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: UIScreen.main.bounds.width * 280 / 375)
            } else {
              Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 280 / 375)
                .padding(.horizontal, 20)
            }
          }
        } else {
          // 로딩 중: Kingfisher를 이용해 비동기로 이미지 로드
          KFImage(imageURL)
            .onSuccess { result in
              if let uiImage = result.image.cgImage.flatMap({ UIImage(cgImage: $0) }) {
                image = uiImage
                isPortrait = uiImage.size.height >= uiImage.size.width
              } else {
                image = result.image
                isPortrait = result.image.size.height >= result.image.size.width
              }
            }
            .onFailure { error in
              logger.error("이미지 로딩 실패: \(error)")
            }
            .placeholder {
              Assets.Images.placeholderImage.swiftUIImage
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
      }
    }
  }
}
