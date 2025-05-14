//
//  LikeAttractionListView.swift
//  Features
//
//  Created by suni on 5/3/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import SharedTypes
import Models

struct LikeAttractionListView: View {
  let attractions: [Attraction]
  let onTapped: (Int) -> Void
  let onLikeTapped: (Int) -> Void
  
  var body: some View {
    ScrollView(showsIndicators: false) {
      LazyVStack(alignment: .leading, spacing: 4) {
        Text(L10n.myJJIMSubText_total("\(attractions.count)"))
          .font(.captionL)
          .foregroundColor(Colors.gray300.swiftUIColor)
          .padding(.leading, 28)
          .padding(.top, 24)
          .padding(.bottom, 8)
        
        ForEach(attractions.indices, id: \.self) { index in
          let attraction = attractions[index]
          
          LikeAttractionItemView(
            attraction: attraction,
            onLikeTapped: { onLikeTapped(attraction.id) }
          )
          .padding(.horizontal, 20)
          .onTapGesture {
            onTapped(attraction.id)
          }
          
          // 마지막 아이템 제외하고만 Divider 추가
          if index < attractions.count - 1 {
            Divider()
              .frame(height: 1)
              .foregroundColor(Colors.gray25.swiftUIColor)
              .padding(.horizontal, 20)
              .padding(.vertical, 4)
          }
        }
      }
    }
    .background(Colors.appWhite.swiftUIColor)
  }
}
