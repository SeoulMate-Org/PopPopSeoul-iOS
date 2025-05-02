//
//  LikeAttractionView.swift
//  Features
//
//  Created by suni on 5/2/25.
//

import SwiftUI
import ComposableArchitecture
import Common
import DesignSystem
import SharedAssets
import SharedTypes
import Models

struct LikeAttractionView: View {
  let store: StoreOf<LikeAttractionFeature>
  @ObservedObject var viewStore: ViewStore<LikeAttractionFeature.State, LikeAttractionFeature.Action>
  
  init(store: StoreOf<LikeAttractionFeature>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
    VStack(spacing: 0) {
      HeaderView(type: .back(title: "찜한 장소", onBack: {
        viewStore.send(.tappedBack)
      }))
      
      if viewStore.attractions.isEmpty {
        LikeAttractionEmptyView()
      } else {
        LikeAttractionListView(
          attractions: viewStore.attractions,
          onTapped: { id in
            viewStore.send(.tappedDetail(id))
          },
          onLikeTapped: { id in
            viewStore.send(.tappedLike(id))
          })
      }
    }
    .overlay(
      Group {
        if viewStore.showUndoToast {
          VStack(spacing: 0) {
            Spacer()
            AppToast(type: .iconTextWithButton(
              message: "찜한 장소가 삭제되었어요",
              buttonTitle: String(sLocalization: .toastButtonRestoration),
              onTap: { viewStore.send(.undoLike) }
            ))
            .padding(.bottom, 16)
          }
          .transition(.opacity.animation(.easeInOut(duration: 0.2)))
        }
      }
    )
    .onAppear {
      viewStore.send(.onApear)
    }
    .navigationBarHidden(true)
  }
}
