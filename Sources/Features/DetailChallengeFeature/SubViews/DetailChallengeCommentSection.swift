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
  let challenge: DetailChallenge
  let onDeleteTap: (Int) -> Void
  let onEditTap: (Comment) -> Void
  let onAllCommentTap: () -> Void
  @State private var activeMenuCommentId: Int? = nil
  
  var body: some View {
    // 댓글
    VStack(alignment: .leading, spacing: 0) {
      // 1. 제목
      let countString = challenge.commentCount > 0 ? " {\(challenge.commentCount)}" : ""
      Text(String(sLocalization: .detailchallengeCommentTitle) + countString)
        .font(.appTitle3)
        .foregroundColor(Colors.gray900.swiftUIColor)
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
            title: String(sLocalization: .detailchallengeCommentButton),
            size: .ssize,
            style: .neutral,
            layout: .textOnly,
            state: .enabled,
            onTap: onAllCommentTap,
            isFullWidth: true
          )
          .frame(height: 40)
          .padding(.vertical, 20)
          .padding(.horizontal, 16)
        }
        
      }
      
      // case2. 로그인 X or Like 챌린지
      if !TokenManager.shared.isLogin || challenge.challengeStatus == nil {
        // TODO: - 챌린지 미진행 체크
        Text(String(sLocalization: .detailchallengeCommentDes))
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
