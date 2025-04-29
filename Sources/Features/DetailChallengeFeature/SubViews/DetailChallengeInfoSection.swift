//
//  DetailChallengeInfoSection.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import Models
import Kingfisher

struct DetailChallengeInfoSection: View {
  let challenge: DetailChallenge
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      // 이미지
      KFImage( URL(string: challenge.imageUrl))
        .placeholder {
          Assets.Images.placeholderImage.swiftUIImage
            .resizable()
            .scaledToFill()
        }.retry(maxCount: 2, interval: .seconds(5))
        .resizable()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 234 / 375)
        .clipped()
      
      // 챌린지 정보
      VStack(alignment: .leading, spacing: 0) {
        Text(challenge.name)
          .lineLimit(1)
          .font(.captionL)
          .foregroundColor(Color.hex(0x2B2B2B))
        
        // 4. 타이틀(소제목)
        Text(challenge.title)
          .font(.appTitle3)
          .foregroundColor(Color.hex(0x2B2B2B))
          .fixedSize(horizontal: false, vertical: true)
          .padding(.top, 4)
        
        // 5. 아이콘+수치
        HStack(spacing: 10) {
          iconStat(image: Assets.Icons.heartFill.swiftUIImage, count: challenge.likedCount)
          iconStat(image: Assets.Icons.profileFill.swiftUIImage, count: challenge.progressCount)
          iconStat(image: Assets.Icons.locationFill.swiftUIImage, count: challenge.attractionCount)
          iconStat(image: Assets.Icons.commentFill.swiftUIImage, count: challenge.commentCount)
        }
        .padding(.top, 36)
        
        // 6. 설명
        Text(challenge.description)
          .font(.captionL)
          .foregroundColor(Colors.gray300.swiftUIColor)
          .fixedSize(horizontal: false, vertical: true)
          .padding(.top, 8)
      }
      .padding(.horizontal, 20)
      .padding(.top, 16)
      
    }
  }
  
  private func iconStat(image: Image, count: Int) -> some View {
    HStack(spacing: 2) {
      image
        .resizable()
        .frame(width: 16, height: 16)
        .foregroundColor(Colors.gray200.swiftUIColor)
      Text("\(count)")
        .font(.captionL)
        .foregroundColor(Colors.gray300.swiftUIColor)
    }
  }
}
