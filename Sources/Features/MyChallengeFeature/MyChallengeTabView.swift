//
//  MyChallengeTabView.swift
//
//

import SwiftUI
import ComposableArchitecture
import Common
import DesignSystem
import SharedTypes

struct MyChallengeTabView: View {
  @State private var store: StoreOf<MyChallengeFeature>
  
  public init(store: StoreOf<MyChallengeFeature>) {
    self.store = store
  }
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(spacing: 0) {
        HeaderView(
          type: .titleOnly(title: String(sLocalization: .mychallengeHeaderTitle))
        )
        
        TopTabView(
          tabs: MyChallengeType.allCases,
          titleProvider: { $0.title },
          selectedTab: viewStore.binding(
            get: \.selectedTab,
            send: MyChallengeFeature.Action.tabChanged
          )
        )

        switch viewStore.selectedTab {
        case .interest:
          if viewStore.interestList.isEmpty {
            MyChallengeEmptyView(
              tab: .interest,
              onTap: {
                // TODO: - 챌린지 찾아보기 이동
              }
            )
          } else {
            ZStack {
              MyChallengeListView(
                tab: .interest,
                items: viewStore.interestList,
                onLikeTapped: { id in
                  viewStore.send(.tappedInterest(id: id))
                })
              .overlay(
                Group {
                  if viewStore.showUndoToast {
                    VStack(spacing: 0) {
                      Spacer()
                      AppToast(type: .iconTextWithButton(
                        message: String(sLocalization: .mychallengeInterestDeleteToast),
                        buttonTitle: String(sLocalization: .toastButtonRestoration),
                        onTap: {
                          viewStore.send(.undoLike)
                        }
                      ))
                      .padding(.bottom, 16)
                    }
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                  }
                }
              )
            }
          }
          
        case .progress:
          if viewStore.progressList.isEmpty {
            MyChallengeEmptyView(
              tab: .progress,
              onTap: {
                // TODO: - 챌린지 찾아보기 이동
              }
            )
          } else {
            MyChallengeListView(
              tab: .progress,
              items: viewStore.progressList,
              onLikeTapped: { id in
                viewStore.send(.tappedInterest(id: id))
              })
          }
        case .completed:
          if viewStore.completedList.isEmpty {
            MyChallengeEmptyView(tab: .completed, onTap: { })
          } else {
            WithViewStore(store, observe: \.self) { viewStore in
              MyChallengeListView(
                tab: .completed,
                items: viewStore.completedList,
                onLikeTapped: { id in
                  viewStore.send(.tappedInterest(id: id))
                })
            }
          }
        }
      }
      .onAppear {
        viewStore.send(.onApear)
      }
    }
  }
}

// MARK: Preview

// MARK: - Helper

extension MyChallengeType {
  var title: String {
    switch self {
    case .interest: String(sLocalization: .mychallengeInterestTitle)
    case .progress: String(sLocalization: .mychallengeInprogressTitle)
    case .completed: String(sLocalization: .mychallengeCompletedTitle)
    }
  }
}
