//
//  DetailChallengeCommentSectionView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import SwiftUI

struct DetailChallengeCommentSectionView: View {
  let challenge: Challenge
  
  var body: some View {
    // 댓글
    VStack(alignment: .leading, spacing: 0) {
      // 1. 제목
      let countString = challenge.comments.count > 0 ? " {\(challenge.comments.count)}" : ""
      Text(String(sLocalization: .detailchallengeCommentTitle) + countString)
        .font(.appTitle3)
        .foregroundColor(Colors.gray900.swiftUIColor)
        .padding(.horizontal, 20)
      
      // 2. 댓글 리스트
      if challenge.comments.count > 0 {
        let displayedComments = challenge.comments.prefix(10)
        
        VStack(spacing: 0) {
          ForEach(displayedComments.indices, id: \.self) { index in
            CommentListItemView(type: .detailChallenge, comment: displayedComments[index], onEditTapped: nil, onDeleteTapped: nil)
            
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
        if challenge.comments.count <= 10 {
          Divider()
            .frame(height: 1)
            .foregroundColor(Colors.gray25.swiftUIColor)
            .padding(.horizontal, 20)
        } else {
          AppButton(title: String(sLocalization: .detailchallengeCommentButton),
                    size: .ssize,
                    style: .neutral,
                    layout: .textOnly,
                    state: .enabled,
                    onTap: {
            // TODO: 댓글 전체보기 이동
          }, isFullWidth: true)
          .frame(height: 40)
          .padding(.vertical, 20)
          .padding(.horizontal, 16)
        }
        
      }
      
      // case2. 로그인 X or 참여중 챌린지 X
      if !isLogined || !challenge.isParticipating {
        Text(String(sLocalization: .detailchallengeCommentDes))
          .font(.bodyS)
          .foregroundStyle(Colors.gray900.swiftUIColor)
          .frame(maxWidth: .infinity, alignment: .center)
          .frame(height: 52)
          .padding(.vertical, 20)
          .padding(.horizontal, 16)
      }
    }
  }
}

#Preview {
  DetailChallengeCommentSectionView(challenge: mockChallenges[0])
}
