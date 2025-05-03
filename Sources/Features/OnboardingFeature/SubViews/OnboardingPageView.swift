//
//  OnboardingPageView.swift
//  Features
//
//  Created by suni on 5/3/25.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import Common
import SharedTypes
import SharedAssets

struct OnboardingPageView: View {
  let index: Int
  let language: AppLanguage

  var body: some View {
    VStack(spacing: 0) {
      imageSection()

      if index == 0 {
        stepList()
          .frame(maxWidth: .infinity)
          .padding(.top, 50)
      } else {
        titleDescriptionSection()
          .padding(.top, 50)
      }
      
      Spacer()
    }
  }

  @ViewBuilder
  private func imageSection() -> some View {
    Group {
      switch index {
      case 0:
        (language == .kor ? Assets.Images.onboardingKor1 : Assets.Images.onboardingEng1).swiftUIImage
          .resizable()
          .scaledToFit()
      case 1:
        (language == .kor ? Assets.Images.onboardingKor2 : Assets.Images.onboardingEng2).swiftUIImage
          .resizable()
          .scaledToFit()
      case 2:
        (language == .kor ? Assets.Images.onboardingKor3 : Assets.Images.onboardingEng3).swiftUIImage
          .resizable()
          .scaledToFit()
      case 3:
        (language == .kor ? Assets.Images.onboardingKor4 : Assets.Images.onboardingEng4).swiftUIImage
          .resizable()
          .scaledToFit()
      default:
        Color.clear
      }
    }
    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 391 / 375)
  }

  @ViewBuilder
  private func stepList() -> some View {
    VStack(alignment: .leading, spacing: 12) {
      stepRow(numberImage: Assets.Images.onboardingNumber1.swiftUIImage, text: L10n.onboardingText_1)
      lineDivider()
      stepRow(numberImage: Assets.Images.onboardingNumber2.swiftUIImage, text: L10n.onboardingText_2)
      lineDivider()
      stepRow(numberImage: Assets.Images.onboardingNumber3.swiftUIImage, text: L10n.onboardingText_3)
    }
  }

  @ViewBuilder
  private func stepRow(numberImage: Image, text: String) -> some View {
    HStack(spacing: 12) {
      numberImage
        .resizable()
        .scaledToFit()
        .frame(width: 28, height: 28)

      Text(text)
        .font(.bodyM).bold()
        .foregroundStyle(Colors.gray900.swiftUIColor)
    }
    .frame(maxHeight: 28)
  }

  @ViewBuilder
  private func lineDivider() -> some View {
    RoundedRectangle(cornerRadius: 4)
      .fill(Colors.gray50.swiftUIColor)
      .frame(width: 3, height: 8)
      .padding(.horizontal, 12.5)
  }

  @ViewBuilder
  private func titleDescriptionSection() -> some View {
    let (title, description): (String, String) = {
      switch index {
      case 1:
        return (L10n.onboardingTitle_2, L10n.onboardingSub_2)
      case 2:
        return (L10n.onboardingTitle_3, L10n.onboardingSub_3)
      case 3:
        return (L10n.onboardingTitle_4, L10n.onboardingSub_4)
      default:
        return ("", "")
      }
    }()
    
    VStack(spacing: 12) {
      Text(title)
        .font(Font.pretendard(size: 25, weight: .semibold))
        .foregroundStyle(Colors.gray900.swiftUIColor)
        .multilineTextAlignment(.center)
        .lineSpacing(9)
        .frame(maxWidth: .infinity, alignment: .center)

      Text(description)
        .font(.bodyM)
        .multilineTextAlignment(.center)
        .lineSpacing(8)
        .foregroundStyle(Colors.gray400.swiftUIColor)
    }
  }
}
