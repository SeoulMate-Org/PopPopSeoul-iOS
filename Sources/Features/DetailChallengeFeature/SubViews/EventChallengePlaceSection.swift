//
//  EventChallengePlaceSection.swift
//  Features
//
//  Created by suni on 5/2/25.
//

import SwiftUI
import Common
import SharedAssets
import SharedTypes
import Models
import DesignSystem

struct EventChallengePlaceSection: View {
  let attraction: Attraction
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      VStack(alignment: .leading, spacing: 2) {
        Text("스탬프 미션 문화행사")
          .font(.appTitle3)
          .foregroundColor(Colors.gray900.swiftUIColor)
        
        Text("아래 문화행사를 방문하면 스탬프가 찍혀요")
          .font(.captionL)
          .foregroundColor(Colors.gray400.swiftUIColor)
          .fixedSize(horizontal: false, vertical: true)
      }
      
      VStack(spacing: 0) {
        if !attraction.address.isEmpty {
          DetailAttractionAddressView(
            text: attraction.address,
            distance: attraction.distance?.formattedDistance
          )
        }
        
        // TODO: 운영시간
        
        if !attraction.homepageUrl.isEmpty,
           let link = URL(string: attraction.homepageUrl) {
          DetailAttractionLinkView(
            text: attraction.homepageUrl,
            link: link
          )
          .padding(.top, 24)
        }
      }
      .padding(.top, 20)
    }
    .padding(.horizontal, 20)
  }
}
