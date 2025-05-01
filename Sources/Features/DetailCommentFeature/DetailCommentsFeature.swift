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
    var initFoucus: Bool
    var shouldFocusTextField: Bool = false
    var deletingComment: Int?
    var enabledSave: Bool = false
    var showToast: Toast?
    
    public init(with id: Int, _ editingComment: Comment? = nil, isFocus: Bool = false) {
      self.challengeId = id
      self.editingComment = editingComment
      self.initFoucus = isFocus
    }
  }
  
  public enum Toast: Equatable {
    case deleteComplete
    case editComplete
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onAppear
    case fetchList
    case updateList([Comment])
    case tappedBack
    case tappedEdit(Comment)
    case tappedDelete(id: Int)
    case error
    
    case inputTextChanged(String)
    case tappedSave
    
    case textFieldFocusChanged(Bool)
    case cancelDeleteComment
    case deleteComment(Int)
    case completeEdit
    case showToast(Toast)
    case dismissToast
  }
  
  // MARK: Reducer
  @Dependency(\.dismiss) var dismiss
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return .run { [state = state] send in
          await send(.fetchList)
          
          if let editingComment = state.editingComment {
            await send(.inputTextChanged(editingComment.comment))
          }
          
          if state.initFoucus {
            await send(.textFieldFocusChanged(true))
          }
          
        }
      case .fetchList:
        return .run { [state = state] send in
          do {
            let id = state.challengeId
            let comments = try await commentClient.get(id)
            await send(.updateList(comments))
          } catch {
            await send(.error)
          }
        }
        
      case .tappedBack:
        return .run { _ in
          await self.dismiss()
        }
        
      case let .updateList(comments):
        state.comments = (comments)
        return .none
        
      case .error:
        // TODO: ERROR 처리
        return .none
        
      case let .inputTextChanged(text):
        state.inputText = text
        state.enabledSave = !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        return .none
        
      case .tappedSave:
        if let editigComment = state.editingComment {
          return .run { [state = state] send in
            do {
              await send(.textFieldFocusChanged(false))
              
              let input = state.inputText
              let comment = try await commentClient.put(editigComment.id, input)
              
              await send(.completeEdit)
              
              var list = state.comments
              if let index = list.firstIndex(where: { $0.id == comment.id }) {
                list[index] = comment
                await send(.updateList(list))
              } else {
                await send(.fetchList)
              }
            } catch {
              await send(.error)
            }
          }
        } else {
          return .run { [state = state] send in
            do {
              await send(.textFieldFocusChanged(false))
              
              let input = state.inputText
              let id = state.challengeId
              let comment = try await commentClient.post(id, input)
              
              await send(.inputTextChanged(""))
              
              var list = state.comments
              list.insert(comment, at: 0)
              
              await send(.updateList(list))
            } catch {
              await send(.error)
            }
          }
        }
                
      case .tappedEdit(let comment):
        state.editingComment = comment
        return .run { send in
          await send(.inputTextChanged(comment.comment))
          await send(.textFieldFocusChanged(true))
        }
        
      case .textFieldFocusChanged(let focus):
        state.shouldFocusTextField = focus
        return .none
        
      case let .tappedDelete(id):
        state.deletingComment = id
        return .none
        
      case let .deleteComment(id):
        state.deletingComment = nil
        return .run { [state = state] send in
          do {
            let result = try await commentClient.delete(id)
            if result.isProcessed {
              await send(.showToast(.deleteComplete))
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
        
      case .completeEdit:
        state.editingComment = nil
        return .run { send in
          await send(.inputTextChanged(""))
          await send(.showToast(.editComplete))
          try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
          await send(.dismissToast)
        }
        
      case let .showToast(toast):
        state.showToast = toast
        return .run { send in
          try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
          await send(.dismissToast)
        }
        
      case .dismissToast:
        state.showToast = nil
        return .none
      }
    }
  }
}

// MARK: - Helper
