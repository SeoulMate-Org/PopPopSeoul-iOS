//
//  AttractionMapView.swift
//  SeoulMateKit
//
//  Created by suni on 4/2/25.
//

import SwiftUI
import ComposableArchitecture
import Common
import DesignSystem
import SharedAssets
import Models

struct AttractionMapView: View {
  let store: StoreOf<AttractionMapFeature>
  @ObservedObject var viewStore: ViewStore<AttractionMapFeature.State, AttractionMapFeature.Action>
  
  @State private var dragOffset: CGFloat = 0
  @State private var contentHeight: CGFloat = 0
  
  init(store: StoreOf<AttractionMapFeature>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
    VStack(spacing: 0) {
      HeaderView(type: .back(title: viewStore.challengeName, onBack: {
        viewStore.send(.tappedBack)
      }))
      
      ZStack(alignment: .bottom) {
        NaverMapView(attractions: viewStore.showAttractions)
          .edgesIgnoringSafeArea(.all)
        
        Colors.appWhite.swiftUIColor
          .frame(height: Utility.safeBottom)
          .frame(maxWidth: .infinity)
          .edgesIgnoringSafeArea(.all)
        
        if let attraction = viewStore.bottomSheetType.attraction {
          detailBottomSheet(attraction)
        } else {
          listBottomSheet
        }
        
      }
      .edgesIgnoringSafeArea(.all)
    }
    .overlay(
      Group {
        if viewStore.showLoginAlert {
          AppLoginAlertView(onLoginTapped: {
            viewStore.send(.loginAlert(.loginTapped))
          }, onCancelTapped: {
            viewStore.send(.loginAlert(.cancelTapped))
          })
        }
      }
    )
    .onAppear {
      viewStore.send(.onApear)
    }
    .navigationBarBackButtonHidden(true)
  }
  
  func detailBottomSheet(_ attraction: Attraction) -> some View {
    VStack {
      if viewStore.showToast == .paste {
        AppToast(type: .text(message: "복사되었습니다."))
          .padding(.bottom, 16)
          .transition(.opacity.animation(.easeInOut(duration: 0.2)))
      }
      VStack(spacing: 0) {
        // 컨텐츠
        AttractionMapDetailView(
          attraction: attraction,
          onDetailTapped: {
            viewStore.send(.tappedDetail(attraction.id))
          },
          onLikeTapped: {
            viewStore.send(.tappedLike(attraction.id))
          },
          onPasteTapped: {
            viewStore.send(.showToast(.paste))
          }
        )
        .background(GeometryReader { proxy in
          Color.clear
            .onAppear {
              contentHeight = proxy.size.height + Utility.safeBottom
            }
        })
      }
      .frame(height: contentHeight)
      .background(Colors.appWhite.swiftUIColor)
      .cornerRadius(24, corners: [.topLeft, .topRight])
    }
  }
  
  var listBottomSheet: some View {
    VStack(spacing: 0) {
      // 컨텐츠
      AttractionMapListView(
        attractions: viewStore.attractions,
        onTapped: { id in
          viewStore.send(.tappedAttraction(id))
        },
        onLikeTapped: { id in
          viewStore.send(.tappedLike(id))
        }
      )
      .background(GeometryReader { proxy in
        Color.clear
          .onAppear {
            contentHeight = proxy.size.height + Utility.safeBottom
          }
      })
    }
    .frame(height: contentHeight)
    .background(Colors.appWhite.swiftUIColor)
    .cornerRadius(24, corners: [.topLeft, .topRight])
    .offset(y: viewStore.bottomSheetType == .expand ? dragOffset : contentHeight - (100 + Utility.safeBottom))
    .gesture(dragGesture)
  }
  
  var dragGesture: some Gesture {
    DragGesture()
      .onChanged { value in
        dragOffset = max(value.translation.height, 0)
      }
      .onEnded { value in
        let threshold: CGFloat = 100
        withAnimation {
          if value.translation.height > threshold {
            viewStore.send(.updateBottomSheetType(.fold))
          } else if value.translation.height < -threshold {
            viewStore.send(.updateBottomSheetType(.expand))
          }
          dragOffset = 0
        }
      }
  }
}
