//
//  MyCommentView.swift
//  Features
//
//  Created by suni on 5/3/25.
//

import SwiftUI
import ComposableArchitecture
import Common
import DesignSystem
import SharedAssets
import SharedTypes
import Models

struct MyCommentView: View {
  let store: StoreOf<MyCommentFeature>
  @ObservedObject var viewStore: ViewStore<MyCommentFeature.State, MyCommentFeature.Action>
  @State private var activeMenuCommentId: Int? = nil
  
  init(store: StoreOf<MyCommentFeature>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
    var body: some View {
      VStack(spacing: 0) {
        HeaderView(type: .back(title: "내 댓글", onBack: {
          viewStore.send(.tappedBack)
        }))
        
        if viewStore.comments.isEmpty {
          MyCommentEmptyView(onTapped: {
            viewStore.send(.moveToHome)
          })
        } else {
          ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 12) {
              ForEach(viewStore.comments, id: \.self) { comment in
                CommentListItemView(
                  type: .myComment,
                  comment: comment,
                  onEditTapped: nil,
                  onDeleteTapped: {
                    viewStore.send(.tappedDelete(comment.id))
                  }, activeMenuCommentId: $activeMenuCommentId
                )
                
                Divider()
                  .frame(height: 1)
                  .foregroundColor(Colors.gray25.swiftUIColor)
                  .padding(.horizontal, 20)
                
              }
            }
          }
          .background(Colors.appWhite.swiftUIColor)
          .overlay {
            if let toast = viewStore.showToast {
              VStack(spacing: 0) {
                Spacer()
                AppToast(type: .iconText(message: toast.message))
                  .padding(.bottom, 16)
              }
              .transition(.opacity.animation(.easeInOut(duration: 0.2)))
            }
          }
        }
      }
      .background(Colors.appWhite.swiftUIColor)
      .onTapGesture {
        activeMenuCommentId = nil
      }
      .onAppear {
        viewStore.send(.onApear)
      }
      .overlay(
        Group {
          if let deletingComment = viewStore.deletingComment {
            AppAlertView(
              title: "댓글을 삭제할까요?",
              message: "삭제한 댓글은 복구할 수 없습니다.",
              primaryButtonTitle: "삭제",
              primaryAction: {
                viewStore.send(.deleteComment(deletingComment))
              },
              secondaryButtonTitle: "취소",
              secondaryAction: {
                viewStore.send(.cancelDeleteComment)
              })
          }
        }
      )
      .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Helper

extension MyCommentFeature.Toast {
  var message: String {
    switch self {
    case .deleteComplete: "댓글이 삭제되었습니다."
    }
  }
}
