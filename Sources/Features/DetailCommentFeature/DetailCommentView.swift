//
//  DetailCommentsView.swift
//  Features
//
//  Created by suni on 4/27/25.
//

import SwiftUI
import ComposableArchitecture
import Common
import DesignSystem
import SharedAssets

struct DetailCommentsView: View {
  let store: StoreOf<DetailCommentsFeature>
  @FocusState private var isTextFieldFocused: Bool
  @ObservedObject var keyboard = KeyboardObserver()
  @State private var activeMenuCommentId: Int? = nil
  
  init(store: StoreOf<DetailCommentsFeature>) {
    self.store = store
  }
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        VStack(spacing: 0) {
          HeaderView(type: .back(title: "댓글", onBack: {
            viewStore.send(.tappedBack)
          }))
          
          ScrollView {
            VStack(alignment: .leading, spacing: 12) {
              ForEach(viewStore.comments, id: \.self) { comment in
                CommentListItemView(
                  type: .challengeComment,
                  comment: comment,
                  onEditTapped: {
                    viewStore.send(.tappedEdit(comment))
                  }, onDeleteTapped: {
                    viewStore.send(.tappedDelete(id: comment.id))
                  }, activeMenuCommentId: $activeMenuCommentId
                )
              }
            }
            .padding()
          }
          
          HStack(alignment: .center) {
            Divider()
            TextField("", text: viewStore.binding(
              get: \.inputText,
              send: DetailCommentsFeature.Action.inputTextChanged
            ))
            .focused($isTextFieldFocused)
            .placeholder(when: viewStore.inputText.isEmpty) {
              Text("댓글을 입력해주세요.")
                .font(.captionL)
                .foregroundColor(Colors.gray300.swiftUIColor)
            }
            .padding(.leading, 8)
            .padding(.trailing, 8)
            .frame(height: 48)
            .font(.captionL)
            .foregroundColor(Colors.gray900.swiftUIColor)
            .background(.clear)
            .multilineTextAlignment(.leading)
            .cornerRadius(0)
            .onChange(of: viewStore.inputText, initial: true) { _, newValue in
              if newValue.count > 400 {
                viewStore.send(.inputTextChanged(String(newValue.prefix(400))))
              }
            }
            .onChange(of: viewStore.shouldFocusTextField, initial: true) { _, newValue in
              isTextFieldFocused = newValue
            }
            .padding(.leading, 16)
            
            Button(action: {
              viewStore.send(.sendButtonTapped)
            }) {
              Assets.Icons.arrowUpperLine.swiftUIImage
                .resizable()
                .frame(width: 16, height: 16)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Colors.appWhite.swiftUIColor)
                .frame(width: 32, height: 32)
                .background(
                  viewStore.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                  ? Colors.gray100.swiftUIColor
                  : Colors.blue500.swiftUIColor
                )
                .cornerRadius(10)
            }
            .padding(.leading, 10)
            .padding(.trailing, 12)
            .disabled(viewStore.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            
          }
          .background(Colors.appWhite.swiftUIColor)
        }
        .padding(.bottom, viewStore.keyboardHeight)
        .onReceive(keyboard.$height) { height in
          if height > 0 {
            viewStore.send(.keyboardWillShow(height))
          } else {
            viewStore.send(.keyboardWillHide)
          }
        }
        .animation(.easeOut(duration: 0.25), value: viewStore.keyboardHeight)
        .onAppear {
          viewStore.send(.onAppear)
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
                }, secondaryButtonTitle: "취소",
                secondaryAction: {
                  viewStore.send(.cancelDeleteComment)
                })
            }
          }
        )
        
        if activeMenuCommentId != nil {
          Color.black.opacity(0.001)
            .ignoresSafeArea()
            .gesture(
              DragGesture(minimumDistance: 0)
                .onChanged { _ in
                  activeMenuCommentId = nil
                }
            )
            .zIndex(1)
        }
      }
    }
  }
}

#Preview {
  DetailCommentsView(store: Store<DetailCommentsFeature.State, DetailCommentsFeature.Action>(
    initialState: .init(with: 1),
    reducer: { DetailCommentsFeature() }
  ))
}
