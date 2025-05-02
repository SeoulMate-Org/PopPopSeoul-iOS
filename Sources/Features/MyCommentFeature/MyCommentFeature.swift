//
//  MyCommentFeature.swift
//  Features
//
//  Created by suni on 5/3/25.
//

import Foundation
import ComposableArchitecture
import Common
import SharedTypes
import Models
import Clients

@Reducer
public struct MyCommentFeature {

  @Dependency(\.commentClient) var commentClient
  
  // MARK: State
  
  @ObservableState
  public struct State: Equatable {
    var comments: [Comment] = []
    
    var recentlyDeleted: Attraction? = nil
    var showUndoToast: Bool = false
    var deletingComment: Int?
    var showToast: Toast?
  }
  
  public enum Toast: Equatable {
    case deleteComplete
  }
  
  // MARK: Actions
  
  @CasePathable
  public enum Action: Equatable {
    case onApear
    case fetch
    case update([Comment])
    case networkError
    
    case tappedBack
    case moveToHome
    
    case tappedDelete(Int)
    case cancelDeleteComment
    case deleteComment(Int)
    case showToast(Toast)
    case dismissToast
  }
  
  // MARK: Reducer
  @Dependency(\.dismiss) var dismiss
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        
      case .onApear:
        return .send(.fetch)
        
      case .fetch:
        return .run { send in
          do {
            let result = try await commentClient.getMy()
            await send(.update(result))
          } catch {
            await send(.networkError)
          }
        }
        
      case let .update(comments):
        state.comments = comments
        return .none

      case .tappedBack:
        return .run { _ in
          await self.dismiss()
        }
        
      case .networkError:
        // TODO: ERROR 처리
        return .none
        
      case .moveToHome:
        // Main Tab Navigation
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
              await send(.update(comments))
            } else {
              await send(.networkError)
            }
          } catch {
            await send(.networkError)
          }
        }
        
      case .cancelDeleteComment:
        state.deletingComment = nil
        return .none
        
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
