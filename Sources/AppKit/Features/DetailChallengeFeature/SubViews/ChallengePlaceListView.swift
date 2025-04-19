//
//  ChallengePlaceListView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import SwiftUI

struct ChallengePlaceListView: View {
  let places: [Place]
  let onToggle: (UUID) -> Void
  
  var body: some View {
    
    // 리스트
    VStack(spacing: 16) {
      ForEach(places) { place in
        ChallengePlaceListItemView(place: place, onLikeTapped: { onToggle(place.id) })
      }
    }
  }
}

#Preview {
  ChallengePlaceListView(places: mockChallenges[0].places, onToggle: { _ in })
}
