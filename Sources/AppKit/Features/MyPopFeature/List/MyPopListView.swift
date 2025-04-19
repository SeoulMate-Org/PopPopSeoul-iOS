//
//  MyPopListView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/19/25.
//

import SwiftUI

struct MyPopListView: View {
  let tab: MyPopFeature.State.Tab
  let items: [Challenge]
  let onLikeTapped: (UUID) -> Void
  
  var body: some View {
    
    ScrollView {
      LazyVStack(alignment: .leading, spacing: 4) {
        Text("전체 {\(items.count)}개")
          .font(.captionL)
          .foregroundColor(Colors.gray300.swiftUIColor)
          .padding(.leading, 28)
          .padding(.top, 24)
          .padding(.bottom, 4)
        
        ForEach(items.indices, id: \.self) { index in
          VStack(spacing: 4) {
            switch tab {
            case .interest, .completed:
              MyPopListItemView(
                challenge: items[index],
                onLikeTapped: { onLikeTapped(items[index].id) }
              )
              .padding(.horizontal, 20)
              .padding(.vertical, 8)
            case .progress:
              EmptyView()
            }
            
            // 마지막 아이템 제외하고만 Divider 추가
            if index < items.count - 1 {
              Divider()
                .padding(.horizontal, 20)
            }
          }
        }
      }
    }
  }
}

// MARK: Preview

#Preview {
  MyPopListView(items: mockChallenges, onLikeTapped: { _ in })
}

// MARK: - Helper

