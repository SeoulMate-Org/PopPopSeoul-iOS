//
//  CompleteChallengeView.swift
//  Features
//
//  Created by suni on 5/1/25.
//

import SwiftUI
import ComposableArchitecture
import Common
import DesignSystem
import SharedAssets
import SharedTypes

struct CompleteChallengeView: View {
  let store: StoreOf<CompleteChallengeFeature>
  @ObservedObject var viewStore: ViewStore<CompleteChallengeFeature.State, CompleteChallengeFeature.Action>
  
  init(store: StoreOf<CompleteChallengeFeature>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
    ZStack(alignment: .top) {
      VStack(spacing: 0) {
        viewStore.theme.badge
          .resizable()
          .scaledToFit()
          .frame(width: 304, height: 304)
        
        Text(L10n.detailBadgeTitle_congrats)
          .font(.appTitle1)
          .foregroundColor(Colors.gray900.swiftUIColor)
          .padding(.top, 26)
        
        Text(L10n.detailBadgeSubText_complete("\(viewStore.theme.title)"))
          .font(.bodyS)
          .foregroundColor(Colors.gray300.swiftUIColor)
          .padding(.top, 6)
      }
      .padding(.top, 105 + Utility.safeTop)
      
      VStack(alignment: .center, spacing: 0) {
        Spacer()
        
        Button {
          viewStore.send(.moveToBadge)
        } label: {
          Text(L10n.textButton_viewMyBadge)
            .font(.buttonM)
            .foregroundColor(Colors.gray900.swiftUIColor)
        }
        
        Button(action: {
          viewStore.send(.tappedDone)
        }) {
          Text(L10n.myTapButtonText_completed)
            .font(.buttonM)
            .foregroundColor(Colors.appWhite.swiftUIColor)
            .frame(maxWidth: .infinity, minHeight: 51)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle()) // ✅ 기본 애니메이션 제거
        .background(Colors.blue500.swiftUIColor)
        .cornerRadius(15)
        .padding(.horizontal, 20)
        .padding(.top, 16)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding(.bottom, 10 + Utility.safeBottom)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .ignoresSafeArea()
    .background(Colors.appWhite.swiftUIColor)
    .onAppear {
      viewStore.send(.onApear)
    }
    .navigationBarBackButtonHidden(true)
  }
}

extension ChallengeTheme {
  var badge: Image {
    switch self {
    case .localTour: return Assets.Images.badgeLocalTour.swiftUIImage
    case .culturalEvent: return Assets.Images.badgeCulturalEvent.swiftUIImage
    case .mustSeeSpots: return Assets.Images.badgeMustSeeSpots.swiftUIImage
    case .photoSpot: return Assets.Images.badgePhotoSpot.swiftUIImage
    case .walkingTour: return Assets.Images.badgeWalkingTour.swiftUIImage
    case .nightViewsMood: return Assets.Images.badgeNightViewsMood.swiftUIImage
    case .foodieHiddenGemes: return Assets.Images.badgeFoodieHiddenGemes.swiftUIImage
    case .exhibitionArt: return Assets.Images.badgeExhibitionArt.swiftUIImage
    case .historyCulture: return Assets.Images.badgeHistoryCulture.swiftUIImage
    }
  }
  
  var badgeDisable: Image {
    switch self {
    case .localTour: return Assets.Images.badgeLocalTourDis.swiftUIImage
    case .culturalEvent: return Assets.Images.badgeCulturalEventDis.swiftUIImage
    case .mustSeeSpots: return Assets.Images.badgeMustSeeSpotsDis.swiftUIImage
    case .photoSpot: return Assets.Images.badgePhotoSpotDis.swiftUIImage
    case .walkingTour: return Assets.Images.badgeWalkingTourDis.swiftUIImage
    case .nightViewsMood: return Assets.Images.badgeNightViewsMoodDis.swiftUIImage
    case .foodieHiddenGemes: return Assets.Images.badgeFoodieHiddenGemesDis.swiftUIImage
    case .exhibitionArt: return Assets.Images.badgeExhibitionArtDis.swiftUIImage
    case .historyCulture: return Assets.Images.badgeHistoryCultureDis.swiftUIImage
    }
  }
}
