//
//  RankChallengeView.swift
//  Features
//
//  Created by suni on 4/29/25.
//

import SwiftUI
import ComposableArchitecture
import Common
import DesignSystem
import SharedAssets
import Clients

struct RankChallengeView: View {
  let store: StoreOf<RankChallengeFeature>
  @ObservedObject var viewStore: ViewStore<RankChallengeFeature.State, RankChallengeFeature.Action>
  
  init(store: StoreOf<RankChallengeFeature>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      HeaderView(type: .back(title: "챌린지 랭킹", onBack: {
        viewStore.send(.tappedBack)
      }))
      
      // MARK: - 리스트
      ScrollView {
        VStack(alignment: .leading, spacing: 0) {
          Text("🏅 챌린지 랭킹")
            .font(.appTitle2)
            .foregroundStyle(Colors.gray900.swiftUIColor)
          
          Text("많이 참여한 챌린지를 순위로 보여드려요!")
            .font(.captionL)
            .foregroundStyle(Colors.gray600.swiftUIColor)
            .padding(.top, 4)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.top, 24)
        
        LazyVStack(alignment: .leading, spacing: 10) {
          ForEach(0..<viewStore.rankList.count, id: \.self) { index in
            let item = viewStore.rankList[index]
            RankChallengeItemView(
              rank: index + 1,
              challenge: item,
              onLikeTapped: {
                
              })
          }
        }
        .padding(.top, 24)
      }
    }
  }
}
