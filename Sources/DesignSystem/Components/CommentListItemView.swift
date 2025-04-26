//
//  CommentListItemView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import SwiftUI
import Common
import SharedAssets
import Models

public struct CommentListItemView: View {
  let type: CommentType
  let comment: Comment
  let onEditTapped: (() -> Void)?
  let onDeleteTapped: (() -> Void)?
  
  @State var showMenu: Bool = false
  
  public init(
    type: CommentType,
    comment: Comment,
    onEditTapped: (() -> Void)?,
    onDeleteTapped: (() -> Void)?
  ) {
    self.type = type
    self.comment = comment
    self.onEditTapped = onEditTapped
    self.onDeleteTapped = onDeleteTapped
  }
  
  public var body: some View {
    ZStack(alignment: .topTrailing) {
      if showMenu {
        Color.black.opacity(0.001) // 거의 투명한 레이어
          .ignoresSafeArea()
          .onTapGesture {
            showMenu = false
          }
          .zIndex(0) // AppMoreMenu 아래 깔리면 안 되므로 최소한 위로
      }
      
      if comment.isMine {
        Button(action: { showMenu = true }) {
          Assets.Icons.more.swiftUIImage
            .foregroundColor(Colors.gray300.swiftUIColor)
            .frame(width: 16, height: 16)
        }
        .frame(width: 36, height: 36)
        .padding(.top, type.verticalPadding - 2)
        .padding(.trailing, 10)
        
        if showMenu {
          AppMoreMenu(
            items: [
              AppMoreMenuItem(
                title: "수정",
                action: {
                  onEditTapped?()
                }),
              AppMoreMenuItem(
                title: "삭제",
                action: {
                  onDeleteTapped?()
                })
            ], onDismiss: {
              showMenu = false
            }, itemHeight: 34
          )
          .fixedSize()
          .padding(.trailing, 20)
          .offset(y: (type.verticalPadding - 2) + 36)
          .transition(.opacity.combined(with: .move(edge: .top)))
          .zIndex(1) // ✅ 위에 떠야 하므로 zIndex 필요
        }
      }
      
      VStack(alignment: .leading, spacing: 0) {
        HStack(spacing: 6) {
          Circle()
            .frame(width: 20, height: 20)
            .foregroundColor(Color.hex(0x779BFF))
          
          Text(comment.nickname)
            .font(.captionSB)
            .foregroundColor(Colors.gray700.swiftUIColor)
        }
        .frame(height: 32)
        .padding(.vertical, 6)
        
        Text(comment.comment)
          .font(.bodyS)
          .foregroundColor(Colors.gray900.swiftUIColor)
        
        Text(comment.createdAt)
          .font(.captionM)
          .foregroundColor(Colors.gray300.swiftUIColor)
          .padding(.top, 4)
      }
      .padding(.horizontal, 20)
      .padding(.vertical, type.verticalPadding)
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
  
  private func relativeDateString(from date: Date) -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .short
    return formatter.localizedString(for: date, relativeTo: Date())
  }
}

// MARK: Preview

// MARK: - Helper

public enum CommentType {
  case detailChallenge
  case myComment
  case challengeComment
  
  var verticalPadding: CGFloat {
    switch self {
    case .detailChallenge: return 16
    case .myComment: return 12
    case .challengeComment: return 12
    }
  }
}
