//
//  DetailCommentsFeature.swift
//  Features
//
//  Created by suni on 4/27/25.
//

import Foundation
import ComposableArchitecture
import Common
import SharedTypes
import Models

@Reducer
public struct DetailCommentsFeature {
  public init() { }
  
  @Dependency(\.commentClient) var commentClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    let challengeId: Int
    var comments: [Comment] = []
    var inputText: String = ""
    var keyboardHeight: CGFloat = 0
    var editingComment: Comment?
    var shouldFocusTextField: Bool = false
    var deletingComment: Int?
    
    public init(with id: Int, _ editingComment: Comment? = nil) {
      self.challengeId = id
      self.editingComment = editingComment
    }
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onApear
    case updateList([Comment])
    case tappedBack
    case tappedEdit(Comment)
    case tappedDelete(id: Int)
    case error
    
    case inputTextChanged(String)
    case sendButtonTapped
    case keyboardWillShow(CGFloat)
    case keyboardWillHide
    
    case textFieldFocusChanged(Bool)
    case cancelDeleteComment
    case deleteComment(Int)
  }
  
  // MARK: Reducer
  @Dependency(\.dismiss) var dismiss
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onApear:
        return .run { [state = state] send in
          do {
            let id = state.challengeId
            let comments = try await commentClient.get(id)
            await send(.updateList(comments))
            
            if state.editingComment != nil {
              await send(.textFieldFocusChanged(true))
            }
          } catch {
            await send(.error)
          }
        }
        
      case .tappedBack:
        return .run { _ in
          await self.dismiss()
        }
        
      case let .updateList(comments):
        state.comments = comments
        return .none
        
      case .error:
        // TODO: ERROR 처리
        return .none
        
      case let .inputTextChanged(text):
        state.inputText = text
        return .none
        
      case .sendButtonTapped:
        if !state.inputText.trimmingCharacters(in: .whitespaces).isEmpty {
//          state.comments.append(state.inputText)
          // TODO: - 댓글 생성 API
          state.inputText = ""
        }
        return .none
        
      case let .keyboardWillShow(height):
        state.keyboardHeight = height
        return .none
        
      case .keyboardWillHide:
        state.keyboardHeight = 0
        return .none
        
      case .tappedEdit(let comment):
        state.editingComment = comment
        return .send(.textFieldFocusChanged(true))
        
      case .textFieldFocusChanged(let focus):
        state.shouldFocusTextField = focus
        return .none
        
      case let .tappedDelete(id):
        state.deletingComment = id
        return .none
        
      case let .deleteComment(id):
        return .run { [state = state] send in
          do {
            let result = try await commentClient.delete(id)
            if result.isProcessed {
             var comments = state.comments
              comments.removeAll(where: { $0.id == result.id })
              await send(.updateList(comments))
            } else {
              await send(.error)
            }
          } catch {
            await send(.error)
          }
        }
        
      case .cancelDeleteComment:
        state.deletingComment = nil
        return .none
      }
    }
  }
}

// MARK: - Helper
