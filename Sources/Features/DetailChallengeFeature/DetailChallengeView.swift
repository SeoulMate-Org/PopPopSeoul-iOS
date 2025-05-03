//
//  DetailChallengeView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import SwiftUI
import ComposableArchitecture
import Common
import DesignSystem
import SharedAssets

struct DetailChallengeView: View {
  let store: StoreOf<DetailChallengeFeature>
  @ObservedObject var viewStore: ViewStore<DetailChallengeFeature.State, DetailChallengeFeature.Action>
  
  init(store: StoreOf<DetailChallengeFeature>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
    ZStack(alignment: .topTrailing) {
      VStack(spacing: 0) {
        // 헤더
        if viewStore.challenge?.challengeStatus == .progress {
          HeaderView(type: .backWithMenu(title: "", onBack: {
            viewStore.send(.tappedBack)
          }, onMore: {
            viewStore.send(.tappedMore)
          }))
        } else {
          HeaderView(type: .back(title: "", onBack: {
            viewStore.send(.tappedBack)
          }))
        }
        
        ZStack(alignment: .bottom) {
          ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
              if let challenge = viewStore.challenge {
                DetailChallengeInfoSection(challenge: challenge)
                divider()
                DetailChallengeStampSection(challenge: challenge)
                divider()
                
                if challenge.isEventChallenge {
                  if let attraction = challenge.attractions.first {
                    EventChallengePlaceSection(
                      challenge: challenge,
                      attraction: attraction,
                      onPasteTapped: {
                        viewStore.send(.showToast(.paste))
                      })
                    divider()
                  }
                } else {
                  DetailChallengePlaceSection(
                    challenge: challenge,
                    onAttractionTap: { id in
                      viewStore.send(.tappedAttraction(id: id))
                    }, onLikeTap: { id in
                      viewStore.send(.tappedAttractionLike(id: id))
                    })
                  divider()
                }
                
                DetailChallengeCommentSection(
                  challenge: challenge,
                  onDeleteTap: { id in
                    viewStore.send(.tappedDeleteComment(id: id))
                  },
                  onEditTap: { comment in
                    viewStore.send(.tappedEditComment(id: challenge.id, comment))
                  },
                  onAllCommentTap: { isFocus in
                    viewStore.send(.tappedAllComments(id: challenge.id, isFocus: isFocus))
                  })
              }
            }
            .padding(.bottom, 100)
          }
          
          VStack(spacing: 8) {
            if let toast = viewStore.showToast {
              if toast == .paste {
                AppToast(type: .text(message: toast.message))
                  .transition(.opacity.animation(.easeInOut(duration: 0.2)))
              } else {
                AppToast(type: .iconText(message: toast.message))
                  .transition(.opacity.animation(.easeInOut(duration: 0.2)))
              }
            }
            
            if viewStore.challenge?.challengeStatus == .progress {
              Text(String(sLocalization: .detailchallengeFloatingText))
                .font(.captionM)
                .foregroundColor(Colors.blue500.swiftUIColor)
                .padding(.vertical, 11)
                .padding(.horizontal, 24)
                .background(Color.hex(0xEDF4FF))
                .overlay(
                  RoundedRectangle(cornerRadius: 18)
                    .stroke(Colors.blue400.swiftUIColor, lineWidth: 1)
                )
                .cornerRadius(18)
                .background(Color.clear)
                .edgesIgnoringSafeArea(.all)
            }
          }
          .padding(.bottom, 10)
        }
        
        if let challenge = viewStore.challenge {
          DetailChallengeBottomSection(
            challenge: challenge,
            onTap: { action in
              viewStore.send(.bottomAction(action))
            })
        }
      }
      
      if viewStore.showMenu {
        AppMoreMenu(
          items: [
            AppMoreMenuItem(
              title: String(sLocalization: .detailchallengeEndButton),
              action: {
                viewStore.send(.quitChallenge)
              })
          ], onDismiss: {
            viewStore.send(.dismissMenu)
          }, itemHeight: 40
        )
        .padding(.trailing, 20)
        .offset(y: 44)
        .transition(.opacity.combined(with: .move(edge: .top)))
        .zIndex(1) // ✅ 위에 떠야 하므로 zIndex 필요
      }
      
      Colors.opacityBlack40.swiftUIColor
        .opacity(viewStore.showDim ? 1 : 0)
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 0.25), value: viewStore.successStamps != nil)
      
    }
    .onAppear {
      viewStore.send(.onApear)
    }
    .overlay(
      Group {
        if viewStore.showLoginAlert {
          AppLoginAlertView(onLoginTapped: {
            viewStore.send(.loginAlert(.loginTapped))
          }, onCancelTapped: {
            viewStore.send(.loginAlert(.cancelTapped))
          })
        }
        
        if let deletingComment = viewStore.deletingComment {
          AppAlertView(
            title: "댓글을 삭제할까요?",
            message: "삭제한 댓글은 복구할 수 없습니다.",
            primaryButtonTitle: "삭제",
            primaryAction: {
              viewStore.send(.deleteComment(deletingComment))
            },
            secondaryButtonTitle: "취소",
            secondaryAction: {
              viewStore.send(.cancelDeleteComment)
            })
        }
        
        SuccessStampAlertView(
          attractions: viewStore.successStamps?.map { $0.name } ?? [],
          onDoneTapped: {
            viewStore.send(.doneSuccessStamps)
          }
        )
        .opacity(viewStore.successStamps != nil ? 1 : 0)
        .offset(y: viewStore.successStamps != nil ? 0 : UIScreen.main.bounds.height)
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: viewStore.successStamps != nil)
      }
    )
    .navigationBarBackButtonHidden(true)
  }
  
  private func divider() -> some View {
    return Divider()
      .frame(height: 2)
      .foregroundColor(Colors.gray25.swiftUIColor)
      .padding(.vertical, 28)
  }
}

// MARK: Preview

// MARK: - Helper
extension DetailChallengeFeature.Toast {
  var message: String {
    switch self {
    case .deleteComplete: "댓글이 삭제되었습니다."
    case .notNearAttraction: "장소 근처에서만 스탬프를 찍을 수 있어요"
    case .paste: "복사되었습니다."
    }
  }
}
