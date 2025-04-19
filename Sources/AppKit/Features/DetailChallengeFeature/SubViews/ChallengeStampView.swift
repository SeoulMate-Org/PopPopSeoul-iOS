//
//  ChallengeStampView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import SwiftUI

struct ChallengeStampView: View {
  let items: [Place]
  private let itemWidth: CGFloat = 48
  
  var body: some View {
    GeometryReader { geo in
      let count = items.count
      let spacing: CGFloat = spacing(for: count)
      let contentWidth = (itemWidth * CGFloat(count)) + (spacing * CGFloat(max(count - 1, 0)))
      let totalWidth = geo.size.width
      let horizontalPadding = max((totalWidth - contentWidth) / 2, 0)
      
      HStack(spacing: spacing) {
        ForEach(items) { item in
          VStack(spacing: 4) {
            if item.isCompleted {
              Assets.Images.stampActive.swiftUIImage
                .resizable()
                .scaledToFill()
                .frame(width: itemWidth, height: itemWidth)
                .clipShape(RoundedRectangle(cornerRadius: itemWidth /  2))
            } else {
              Assets.Images.stampInactive.swiftUIImage
                .resizable()
                .scaledToFill()
                .frame(width: itemWidth, height: itemWidth)
                .clipShape(RoundedRectangle(cornerRadius: itemWidth /  2))
            }
            
            Text("관광지")
              .font(.captionM)
              .foregroundColor(item.isCompleted ? Colors.blue500.swiftUIColor : Colors.gray300.swiftUIColor)
              .lineLimit(1)
          }
        }
      }
      .padding(.horizontal, horizontalPadding)
      .frame(width: geo.size.width)
    }
    .frame(height: 66)
  }
  
  private func spacing(for count: Int) -> CGFloat {
    switch count {
    case 1: return 0
    case 2: return 80
    case 3: return 36
    case 4: return 24
    case 5: return 13.75
    default: return 8
    }
  }
}

#Preview {
  ChallengeStampView(items: mockChallenges[0].places)
}
