//
//  DetailAttractionInfoSection.swift
//  Features
//
//  Created by suni on 4/30/25.
//

import SwiftUI
import Common
import SharedAssets
import SharedTypes
import Models
import DesignSystem

struct DetailAttractionInfoSection: View {
  let attraction: Attraction
  
  var body: some View {
    
    VStack(spacing: 8) {
      if !attraction.address.isEmpty {
        DetailAttractionAddressView(
          text: attraction.address,
          distance: attraction.distance?.formattedDistance
        )
      }
      
      if !attraction.homepageUrl.isEmpty,
         let link = URL(string: attraction.homepageUrl) {
        DetailAttractionLinkView(
          text: attraction.homepageUrl,
          link: link
        )
      }
      
      if !attraction.tel.isEmpty {
        DetailAttractionTelView(text: attraction.tel)
      }
      
      if !attraction.subway.isEmpty {
        DetailAttractionSubwayView(text: attraction.subway)
      }
    }
    .padding(.horizontal, 20)
  }
}
