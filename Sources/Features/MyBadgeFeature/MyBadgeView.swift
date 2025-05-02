//
//  MyBadgeView.swift
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

struct MyBadgeView: View {
  let store: StoreOf<MyBadgeFeature>
  @ObservedObject var viewStore: ViewStore<MyBadgeFeature.State, MyBadgeFeature.Action>
  
  let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
  
  init(store: StoreOf<MyBadgeFeature>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
    
    UIScrollView.appearance().bounces = false
  }
  
  var body: some View {
    VStack(spacing: 0) {
      HeaderView(type: .back(title: "내 배지", onBack: {
        viewStore.send(.tappedBack)
      }))
      
      ScrollView(showsIndicators: false) {
        prompt()
          .padding(.vertical, 24)
        
        // MARK: - Grid
        LazyVGrid(columns: columns, spacing: 12) {
          ForEach(viewStore.badges, id: \.self) { badge in
            BadgeCardView(badge: badge)
          }
        }
        .padding(.horizontal, 20)
      }
      .background(Colors.gray25.swiftUIColor)
    }
    .onAppear {
      viewStore.send(.onApear)
    }
    .navigationBarHidden(true)
  }
  
  private func prompt() -> some View {
    HStack {
      VStack(alignment: .leading, spacing: 4) {
        Text("배지를 모아갈수록 완주에 가까워져요!")
          .lineLimit(1)
          .font(.captionM)
          .foregroundColor(Colors.gray500.swiftUIColor)
        
        Text("서울을 모두 채워볼 준비 되셨나요?")
          .lineLimit(1)
          .font(.buttonM)
          .foregroundColor(Colors.gray900.swiftUIColor)
      }
      .padding(.leading, 16)
      .padding(.top, 20)
      .padding(.bottom, 15)
      
      Spacer()
      
      Assets.Images.mybadgePrompt.swiftUIImage
        .resizable()
        .scaledToFit()
        .frame(width: 59, height: 59)
        .padding(.top, 12)
        .padding(.trailing, 19)
        .rotationEffect(.degrees(27))
    }
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(Color.hex(0xFDFBF9))
    )
    .padding(.horizontal, 20)
  }
}
