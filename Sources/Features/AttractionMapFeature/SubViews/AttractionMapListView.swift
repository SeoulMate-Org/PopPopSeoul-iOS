//
//  AttractionMapListView.swift
//  Features
//
//  Created by suni on 4/30/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import Models

struct AttractionMapListView: View {
  
  let attractions: [Attraction]
  let onTapped: (Int) -> Void
  let onLikeTapped: (Int) -> Void
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      ForEach(attractions.indices, id: \.self) { index in
        let attraction = attractions[index]
        AttractionMapListItem(
          attraction: attraction,
          onLikeTapped: {
            onLikeTapped(attraction.id)
          }
        )
        .onTapGesture {
          onTapped(attraction.id)
        }
        
        if index < attractions.count - 1 {
          Divider()
            .foregroundStyle(Colors.gray25.swiftUIColor)
            .frame(height: 1)
            .padding(.vertical, 4)
        }
      }
    }
    .padding(.horizontal, 20)
    .padding(.top, 20)
    .padding(.bottom, 16)
    .background(Color.clear)
  }
}
