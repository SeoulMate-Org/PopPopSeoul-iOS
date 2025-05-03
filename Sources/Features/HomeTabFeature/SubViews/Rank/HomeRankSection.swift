//
//  HomeRankSection.swift
//  Features
//
//  Created by suni on 4/29/25.
//

import SwiftUI
import Common
import DesignSystem
import Clients
import SharedAssets
import SharedTypes
import Models

struct HomeRankSection: View {
  let challenges: [Challenge]
//  let onMoreTapped: () -> Void // FIXME: - 1차 오픈에서 hidden
  let onLikeTapped: (Challenge) -> Void
  let onTapped: (Int) -> Void
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      
      // MARK: - 헤더 타이틀 + 더보기
      VStack(alignment: .leading, spacing: 0) {
        Text(L10n.homeBackGroundText_ranking)
          .font(.appTitle2)
          .foregroundStyle(Colors.gray900.swiftUIColor)
        
        HStack(alignment: .bottom) {
          Text(L10n.homeBackGroundText_mostPopular)
            .font(.captionL)
            .foregroundStyle(Colors.gray600.swiftUIColor)
          
          Spacer()
          
//          Button(action: {
//            onMoreTapped()
//          }) {
//            Text("더보기")
//              .font(.captionM)
//              .foregroundColor(Colors.gray400.swiftUIColor)
//          }
        }
        .padding(.top, 4)
      }
      .padding(.horizontal, 20)
      .padding(.top, 30)
      
      // MARK: - 리스트
      VStack(spacing: 12) {
        ForEach(challenges.prefix(5).indices, id: \.self) { index in
          let item = challenges[index]
          
          HomeRankChallengeItemView(
            rank: index + 1,
            challenge: item,
            onLikeTapped: {
              onLikeTapped(item)
            })
          .onTapGesture {
            onTapped(item.id)
          }
        }
      }
      .padding(.top, 16)
      .padding(.bottom, 48)
      .padding(.horizontal, 20)
    }
    .background(Colors.gray25.swiftUIColor)
  }
}
