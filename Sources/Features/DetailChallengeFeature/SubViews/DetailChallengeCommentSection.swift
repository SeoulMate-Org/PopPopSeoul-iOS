//
//  DetailChallengeCommentSection.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import SwiftUI
import Common
import DesignSystem
import SharedAssets
import Models
import Clients

struct DetailChallengeCommentSection: View {
  let challenge: Challenge
  let onDeleteTap: (Int) -> Void
  let onEditTap: (Comment) -> Void
  let onAllCommentTap: (Bool) -> Void
  @State private var activeMenuCommentId: Int? = nil
  
  var body: some View {
    // 댓글
    VStack(alignment: .leading, spacing: 0) {
      // 1. 제목
      HStack(alignment: .center) {
        let countString = challenge.commentCount > 0 ? " \(challenge.commentCount)" : ""
        Text(L10n.detailmenuItem_comment + countString)
          .font(.appTitle3)
          .foregroundColor(Colors.gray900.swiftUIColor)
        
        Spacer()
        if challenge.myStampCountLocal > 0 {
          Button(action: {
            onAllCommentTap(true)
          }) {
            Assets.Icons.writeLine.swiftUIImage
              .resizable()
              .frame(width: 20, height: 20)
              .foregroundColor(Colors.gray300.swiftUIColor)
          }.frame(width: 36, height: 36)
        }
      }
      .padding(.horizontal, 20)
      
      // 2. 댓글 리스트
      if challenge.commentCount > 0 {
        let displayedComments = challenge.comments.prefix(10)
        
        VStack(spacing: 0) {
          ForEach(displayedComments.indices, id: \.self) { index in
            CommentListItemView(
              type: .detailChallenge,
              comment: displayedComments[index],
              onEditTapped: {
                onEditTap(displayedComments[index])
              }, onDeleteTapped: {
                onDeleteTap(displayedComments[index].id)
              }, activeMenuCommentId: $activeMenuCommentId)
            
            // 마지막 아이템 제외하고만 Divider 추가
            if index < displayedComments.count - 1 {
              Divider()
                .frame(height: 1)
                .foregroundColor(Colors.gray25.swiftUIColor)
                .padding(.horizontal, 20)
            }
          }
        }
        .padding(.top, 16)
        
        // case1. 댓글 수에 따라 Divider or 전체보기 버튼
        if challenge.commentCount <= 10 {
          Divider()
            .frame(height: 1)
            .foregroundColor(Colors.gray25.swiftUIColor)
            .padding(.horizontal, 20)
        } else {
          AppButton(
            title: L10n.textButton_allComments,
            size: .ssize,
            style: .neutral,
            layout: .textOnly,
            state: .enabled,
            onTap: { onAllCommentTap(false) },
            isFullWidth: true
          )
          .frame(height: 40)
          .padding(.vertical, 20)
          .padding(.horizontal, 16)
        }
        
      }
      
      // case2. 로그인 X or 미진행 챌린지
      if !TokenManager.shared.isLogin || challenge.myStampCountLocal <= 0 {
        Text(L10n.detailChallengeCommentText)
          .font(.bodyS)
          .foregroundStyle(Colors.gray900.swiftUIColor)
          .frame(maxWidth: .infinity, alignment: .center)
          .frame(height: 52)
          .padding(.vertical, 20)
          .padding(.horizontal, 16)
      }
    }
    .gesture(
      DragGesture(minimumDistance: 0)
        .onChanged { _ in
          activeMenuCommentId = nil
        }
    )
  }
}
