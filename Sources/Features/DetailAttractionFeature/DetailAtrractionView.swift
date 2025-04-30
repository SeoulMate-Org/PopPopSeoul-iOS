//
//  DetailAtrractionView.swift
//  Features
//
//  Created by suni on 4/30/25.
//

import SwiftUI
import ComposableArchitecture
import Common
import DesignSystem
import SharedAssets

struct DetailAtrractionView: View {
  let store: StoreOf<DetailAttractionFeature>
  @ObservedObject var viewStore: ViewStore<DetailAttractionFeature.State, DetailAttractionFeature.Action>
  
  init(store: StoreOf<DetailAttractionFeature>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
    ZStack(alignment: .topTrailing) {
      VStack(spacing: 0) {
        // 헤더
        HeaderView(type: .back(title: "", onBack: {
          viewStore.send(.tappedBack)
        }))
        
        ScrollView {
          VStack(alignment: .leading, spacing: 0) {
            if let attraction = viewStore.attraction {
              DetailAttractionTopSection(
                attraction: attraction,
                onLikeTapped: {
                  
                })
              divider()
              
              DetailAttractionInfoSection(attraction: attraction)
            }
            
            if let data = viewStore.map,
               let uiImage = UIImage(data: data) {
              DetailAttractionMapSection(
                image: Image(uiImage: uiImage),
                onMapTapped: {
                  viewStore.send(.tappedNaverMap)
                })
              .padding(.top, 24)
            }
          }
          .padding(.bottom, 80)
        }
      }
    }
    .onAppear {
      viewStore.send(.onApear)
    }
    .navigationBarBackButtonHidden(true)
  }
  
  private func divider() -> some View {
    return Divider()
      .frame(height: 2)
      .foregroundColor(Colors.gray25.swiftUIColor)
      .padding(.vertical, 16)
  }
}

// MARK: Preview

// MARK: - Helper
