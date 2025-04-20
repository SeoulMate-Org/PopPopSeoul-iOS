//
//  ChallengeDetailView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import SwiftUI
import ComposableArchitecture
import Common

struct ChallengeDetailView: View {
  let challenge: Challenge
  @State private var showMenu = false
  @State private var isParticipating = true

  var body: some View {
    ZStack(alignment: .topTrailing) {
      VStack(spacing: 0) {
        // 헤더
        if isParticipating {
          HeaderView(type: .backWithMenu(title: "", onBack: {
            // TODO: 뒤로가기
          }, onMore: {
            showMenu = true
          }))
        } else {
          HeaderView(type: .back(title: "", onBack: { }))
        }
        
        ScrollView {
          VStack(alignment: .leading, spacing: 0) {
            // 이미지
            AsyncImage(url: URL(string: challenge.imageURL)) { image in
              image
                .resizable()
                .scaledToFill()
            } placeholder: {
              Assets.Images.placeholderImage.swiftUIImage
                .resizable()
                .scaledToFill()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 234 / 375)
            .clipped()
            
            // 챌린지 정보
            VStack(alignment: .leading, spacing: 0) {
              Text(challenge.name)
                .lineLimit(1)
                .font(.captionL)
                .foregroundColor(Color.hex(0x2B2B2B))
              
              // 4. 타이틀(소제목)
              Text(challenge.subtitle)
                .font(.appTitle3)
                .foregroundColor(Color.hex(0x2B2B2B))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 4)
              
              // 5. 아이콘+수치
              HStack(spacing: 10) {
                iconStat(image: Assets.Icons.heartFill.swiftUIImage, count: challenge.likeCount)
                iconStat(image: Assets.Icons.profileFill.swiftUIImage, count: challenge.participantCount)
                iconStat(image: Assets.Icons.locationFill.swiftUIImage, count: challenge.places.count)
                iconStat(image: Assets.Icons.commentFill.swiftUIImage, count: challenge.commentCount)
              }
              .padding(.top, 36)
              
              // 6. 설명
              Text(challenge.description)
                .font(.captionL)
                .foregroundColor(Colors.gray300.swiftUIColor)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 8)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            
            Divider()
              .frame(height: 2)
              .foregroundColor(Colors.gray25.swiftUIColor)
              .padding(.vertical, 28)
            
            // 스탬프 정보
            VStack(alignment: .leading, spacing: 0) {
              // 1. 제목
              Text(String(sLocalization: .detailchallengeStampTitle))
                .font(.appTitle3)
                .foregroundColor(Colors.gray900.swiftUIColor)
              
              // 2. 설명
              Text(String(sLocalization: .detailchallengeStampDes))
                .font(.captionL)
                .foregroundColor(Colors.gray400.swiftUIColor)
                .padding(.top, 2)
              
              // 3. 회색 배경 박스
              VStack(spacing: 0) {
                ProgressBar(progressType: .detailChallenge, total: challenge.places.count, current: challenge.completeCount)
                  .padding(.horizontal, 20)
                  .padding(.vertical, 17)
                Divider()
                ChallengeStampView(items: challenge.places)
                  .padding(.vertical, 16)
              }
              .background(Colors.gray25.swiftUIColor)
              .cornerRadius(20)
              .padding(.top, 16)
            }
            .padding(.horizontal, 20)
            
            Divider()
              .frame(height: 2)
              .foregroundColor(Colors.gray25.swiftUIColor)
              .padding(.vertical, 28)
            
            // 스탬프 미션 장소
            VStack(alignment: .leading, spacing: 0) {
              // 1. 제목
              Text(String(sLocalization: .detailchallengePlaceTitle))
                .font(.appTitle3)
                .foregroundColor(Colors.gray900.swiftUIColor)
              
              // 2. 설명
              Text(String(sLocalization: .detailchallengePlaceDes))
                .font(.captionL)
                .foregroundColor(Colors.gray400.swiftUIColor)
                .padding(.top, 2)
              
              // 장소 리스트
              VStack(spacing: 16) {
                ForEach(challenge.places) { place in
                  ChallengePlaceListItemView(place: place, onLikeTapped: { })
                }
              }
              .padding(.top, 4)
            }
            .padding(.horizontal, 20)
            
            Divider()
              .frame(height: 2)
              .foregroundColor(Colors.gray25.swiftUIColor)
              .padding(.vertical, 28)
            
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
                
                VStack(spacing: 16) {
                  ForEach(displayedComments.indices, id: \.self) { index in
                    CommentListItemView(comment: displayedComments[index], onEditTapped: nil, onDeleteTapped: nil)
                    
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
                    .padding(.top, 16)
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
              if !isLogined || !isParticipating {
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
      }
      
      if showMenu {
        AppMoreMenu(items: [AppMoreMenuItem(title: String(sLocalization: .detailchallengeEndButton), action: {
          // TODO: 챌린지 그만 두기
        })], onDismiss: {
          showMenu = false
        }, itemHeight: 40)
        .padding(.trailing, 20)
        .offset(y: 44) // 헤더 아래 + 살짝 여유
        .transition(.opacity.combined(with: .move(edge: .top)))
        .zIndex(1) // ✅ 위에 떠야 하므로 zIndex 필요
      }
    }
  }

  private func iconStat(image: Image, count: Int) -> some View {
    HStack(spacing: 2) {
      image
        .resizable()
        .frame(width: 16, height: 16)
        .foregroundColor(Colors.gray200.swiftUIColor)
      Text("\(count)")
        .font(.captionL)
        .foregroundColor(Colors.gray300.swiftUIColor)
    }
  }
}

// MARK: Preview

#Preview {
  ChallengeDetailView(challenge: mockChallenges[0])
}

// MARK: - Helper
