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
    LikeAttractionEmptyView()
  }
}
