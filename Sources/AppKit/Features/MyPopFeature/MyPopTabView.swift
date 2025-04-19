//
//  MyPopTabView.swift
//
//

import SwiftUI
import ComposableArchitecture
import Common

struct MyPopTabView: View {
  @State private var store: StoreOf<MyPopFeature>
  
  public init(store: StoreOf<MyPopFeature>) {
    self.store = store
  }
  
  var body: some View {
    WithViewStore(store, observe: \.self) { viewStore in
      VStack(spacing: 0) {
        CommonHeaderView(
          type: .titleOnly(title: String(sLocalization: .mypopHeaderTitle))
        )
        
        CommonTopTabView(
          tabs: MyPopFeature.State.Tab.allCases,
          titleProvider: { $0.title },
          selectedTab: viewStore.binding(
            get: \.tab,
            send: MyPopFeature.Action.tabChanged
          )
        )
        
        Group {
          switch viewStore.tab {
          case .interest:
            if viewStore.interestList.isEmpty {
              CommonEmptyView(
                image: Assets.Images.emptyPop.swiftUIImage,
                title: String(sLocalization: .mypopInterestEmptyTitle),
                text: String(sLocalization: .mypopInterestEmptyDes),
                buttonTitle: String(sLocalization: .mypopInterestEmptyButton),
                onTap: { }
              )
            } else {
              MyPopListView(items: viewStore.interestList)
            }

          case .progress:
            Text("진행중")
              .frame(maxWidth: .infinity, maxHeight: .infinity)
          case .completed:
            Text("완료")
              .frame(maxWidth: .infinity, maxHeight: .infinity)
          }
        }
      }
      .onAppear {
        viewStore.send(.fetchList)
      }
    }
  }
}

// MARK: Preview

#Preview {
  MyPopTabView(
    store: Store<MyPopFeature.State, MyPopFeature.Action>(
      initialState: .init(),
      reducer: { MyPopFeature() }
    )
  )
}

// MARK: - Helper

extension MyPopFeature.State.Tab {
  var title: String {
    switch self {
    case .interest: String(sLocalization: .mypopInterestTitle)
    case .progress: String(sLocalization: .mypopInprogressTitle)
    case .completed: String(sLocalization: .mypopCompletedTitle)
    }
  }
}
