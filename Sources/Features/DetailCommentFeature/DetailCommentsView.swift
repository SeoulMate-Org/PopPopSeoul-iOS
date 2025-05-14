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
  @State private var activeMenuCommentId: Int? = nil
  
  init(store: StoreOf<DetailCommentsFeature>) {
    self.store = store
  }
  
  var body: some View {
    GeometryReader { geo in
      WithViewStore(store, observe: { $0 }) { viewStore in
        VStack(spacing: 0) {
          Colors.trueWhite.swiftUIColor
            .frame(height: geo.safeAreaInsets.top)
          
          HeaderView(type: .back(title: L10n.detailmenuItem_comment, onBack: {
            viewStore.send(.tappedBack)
          }))
          
          if viewStore.comments.count > 0 {
            ScrollView(showsIndicators: false) {
              LazyVStack(alignment: .leading, spacing: 12) {
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
          } else {
            VStack(alignment: .center) {
              Text(L10n.detailCommentsText)
                .font(.bodyS)
                .foregroundStyle(Colors.gray900.swiftUIColor)
                .padding(.top, 36)
              Spacer()
            }
          }
          
          editCommentView(viewStore: viewStore)
          
          Colors.appWhite.swiftUIColor
            .frame(height: geo.safeAreaInsets.bottom)
        }
        .onAppear {
          viewStore.send(.onAppear)
        }
        .overlay(
          Group {
            if let deletingComment = viewStore.deletingComment {
              AppAlertView(
                title: L10n.alertTitle_deleteComments,
                message: L10n.alertContent_notRestored,
                primaryButtonTitle: L10n.reviewSubButton_delete,
                primaryAction: {
                  viewStore.send(.deleteComment(deletingComment))
                },
                secondaryButtonTitle: L10n.textButton_cancel,
                secondaryAction: {
                  viewStore.send(.cancelDeleteComment)
                })
            }
          }
        )
        .ignoresSafeArea(.all)
        .background(Colors.appWhite.swiftUIColor)
        .onTapGesture {
          activeMenuCommentId = nil
          viewStore.send(.textFieldFocusChanged(false))
        }
        .navigationBarBackButtonHidden(true)
      }
    }
  }
  
  @ViewBuilder
  private func editCommentView(viewStore: ViewStore<DetailCommentsFeature.State, DetailCommentsFeature.Action>) -> some View {
    VStack(alignment: .leading) {
      Divider()
        .frame(height: 1)
        .foregroundColor(Colors.gray50.swiftUIColor)
      
      HStack(alignment: .center, spacing: 0) {
        TextField("", text: viewStore.binding(
          get: \.inputText,
          send: DetailCommentsFeature.Action.inputTextChanged
        ))
        .focused($isTextFieldFocused)
        .placeholder(when: viewStore.inputText.isEmpty) {
          Text(L10n.commentFormText_enter)
            .font(.captionL)
            .foregroundColor(Colors.gray300.swiftUIColor)
        }
        .padding(.leading, 8)
        .padding(.trailing, 8)
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
        .onChange(of: viewStore.shouldFocusTextField, initial: false) { _, newValue in
          isTextFieldFocused = newValue
        }
        .onChange(of: isTextFieldFocused, initial: false, { _, newValue in
          viewStore.send(.textFieldFocusChanged(newValue))
        })
        .padding(.leading, 16)
        
        Button(action: {
          viewStore.send(.tappedSave)
        }) {
          Assets.Icons.arrowUpperLine.swiftUIImage
            .resizable()
            .frame(width: 16, height: 16)
            .foregroundColor(Colors.appWhite.swiftUIColor)
        }
        .frame(width: 32, height: 32)
        .background(
          viewStore.enabledSave
          ? Colors.blue500.swiftUIColor
          : Colors.gray100.swiftUIColor
        )
        .cornerRadius(10)
        .padding(.leading, 10)
        .padding(.trailing, 12)
        .disabled(!viewStore.enabledSave)
      }
      .frame(maxWidth: .infinity)
      .frame(height: 48)
      
      Divider()
        .frame(height: 1)
        .foregroundColor(Colors.gray50.swiftUIColor)
    }
    .background(Colors.trueWhite.swiftUIColor)
  }
}

// MARK: Preview

#Preview {
  DetailCommentsView(store: Store<DetailCommentsFeature.State, DetailCommentsFeature.Action>(
    initialState: .init(with: 1),
    reducer: { DetailCommentsFeature() }
  ))
}

// MARK: - Helper

extension DetailCommentsFeature.Toast {
  var message: String {
    switch self {
    case .editComplete: L10n.commentToastText_updated
    case .deleteComplete: L10n.commentToastText_deleted
    }
  }
}
