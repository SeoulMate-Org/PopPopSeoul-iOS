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
      stepRow(numberImage: Assets.Images.onboardingNumber1.swiftUIImage, text: "마음에 드는 여행 챌린지를 골라요")
      lineDivider()
      stepRow(numberImage: Assets.Images.onboardingNumber2.swiftUIImage, text: "장소를 방문하고 스탬프를 직접 찍어요")
      lineDivider()
      stepRow(numberImage: Assets.Images.onboardingNumber3.swiftUIImage, text: "스탬프를 모아 배지를 획득해요")
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
        return ("관광지를 방문하고\n스탬프를 찍어보세요!", "50m 이내로 가까워지면\n스탬프를 직접 찍을 수 있어요.")
      case 2:
        return ("한국 감성 가득한 배지,\n다 모아볼까요?", "하나의 챌린지를 완성하면\n배지를 얻을 수 있어요.")
      case 3:
        return ("하고 싶은 챌린지를\n‘찜’해 보세요!", "나만의 챌린지를 기록하고 다시 찾아보세요.")
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
