//
//  ChallengeStampView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import Models

struct ChallengeStampView: View {
  let items: [Attraction]
  let stampCount: Int
  private let itemSize: CGFloat = 48
  
  var body: some View {
    HStack {
      if items.count == 5 {
        // ✅ 정확한 균등 정렬
        ForEach(0..<items.count, id: \.self) { index in
          stampImage(for: index < stampCount)
            .frame(width: itemSize, height: itemSize)
            .clipShape(RoundedRectangle(cornerRadius: itemSize / 2))
          
          if index < items.count - 1 {
            Spacer(minLength: 0) // ✅ 균등 분배 간격
          }
        }
      } else {
        // ✅ 고정 spacing + 가운데 정렬
        let spacing = spacing(for: items.count)
        
        HStack(spacing: spacing) {
          ForEach(0..<items.count, id: \.self) { index in
            stampImage(for: index < stampCount)
              .frame(width: itemSize, height: itemSize)
              .clipShape(RoundedRectangle(cornerRadius: itemSize / 2))
          }
        }
        .frame(maxWidth: .infinity)
      }
    }
    .padding(.horizontal, 20)
    .frame(height: itemSize)
  }
  
  private func spacing(for count: Int) -> CGFloat {
    switch count {
    case 2: return 80
    case 3: return 36
    case 4: return 24
    default: return 0      // fallback
    }
  }
  
  @ViewBuilder
  private func stampImage(for isStamped: Bool) -> some View {
    (isStamped ? Assets.Images.stampActive.swiftUIImage : Assets.Images.stampInactive.swiftUIImage)
      .resizable()
      .scaledToFill()
  }
}
