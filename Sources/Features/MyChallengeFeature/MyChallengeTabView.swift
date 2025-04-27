//
//  MyChallengeTabView.swift
//
//

import SwiftUI
import ComposableArchitecture
import Common
import DesignSystem
import SharedTypes
import Models

struct MyChallengeTabView: View {
  var store: StoreOf<MyChallengeTabFeature>
  
  init(store: StoreOf<MyChallengeTabFeature>) {
    self.store = store
  }
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      rootView(viewStore: viewStore)
    }
  }
  
  private func rootView(viewStore: ViewStoreOf<MyChallengeTabFeature>) -> some View {
    VStack(spacing: 0) {
      HeaderView(
        type: .titleOnly(title: String(sLocalization: .mychallengeHeaderTitle))
      )
      
      TopTabView(
        tabs: MyChallengeTabFeature.Tab.allCases,
        titleProvider: { $0.title },
        selectedTab: viewStore.binding(
          get: \.selectedTab,
          send: MyChallengeTabFeature.Action.tabChanged
        )
      )
      tabContent(viewStore: viewStore)
    }
    .onAppear {
      viewStore.send(.onApear)
    }
  }
  private func tabContent(viewStore: ViewStoreOf<MyChallengeTabFeature>) -> some View {
    VStack(spacing: 0) {
      switch viewStore.selectedTab {
      case .interest:
        if viewStore.interestList.isEmpty {
          MyChallengeEmptyView(
            tab: .interest,
            onTap: { /* TODO */ }
          )
        } else {
          listView(viewStore: viewStore, items: viewStore.interestList, tab: .interest)
        }
        
      case .progress:
        if viewStore.progressList.isEmpty {
          MyChallengeEmptyView(
            tab: .progress,
            onTap: { /* TODO */ }
          )
        } else {
          listView(viewStore: viewStore, items: viewStore.progressList, tab: .progress)
        }
        
      case .completed:
        if viewStore.completedList.isEmpty {
          MyChallengeEmptyView(tab: .completed, onTap: { })
        } else {
          listView(viewStore: viewStore, items: viewStore.completedList, tab: .completed)
        }
      }
    }
  }
  
  private func listView(
    viewStore: ViewStoreOf<MyChallengeTabFeature>,
    items: [MyChallenge],
    tab:  MyChallengeTabFeature.Tab
  ) -> some View {
    MyChallengeListView(
      tab: tab,
      items: items,
      onItemTapped: { id in viewStore.send(.tappedItem(id: id)) },
      onLikeTapped: { id in viewStore.send(.tappedInterest(id: id)) }
    )
    .overlay(
      Group {
        if viewStore.showUndoToast {
          VStack(spacing: 0) {
            Spacer()
            AppToast(type: .iconTextWithButton(
              message: String(sLocalization: .mychallengeInterestDeleteToast),
              buttonTitle: String(sLocalization: .toastButtonRestoration),
              onTap: { viewStore.send(.undoLike) }
            ))
            .padding(.bottom, 16)
          }
          .transition(.opacity.animation(.easeInOut(duration: 0.2)))
        }
      }
    )
  }
}

// MARK: Preview

// MARK: - Helper

extension  MyChallengeTabFeature.Tab {
  var title: String {
    switch self {
    case .interest: String(sLocalization: .mychallengeInterestTitle)
    case .progress: String(sLocalization: .mychallengeInprogressTitle)
    case .completed: String(sLocalization: .mychallengeCompletedTitle)
    }
  }
}
