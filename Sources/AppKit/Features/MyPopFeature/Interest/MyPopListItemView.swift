//
//  MyPopListItemView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/19/25.
//

import SwiftUI

struct MyPopListItemView: View {
  let challenge: Challenge

  var body: some View {
    HStack(alignment: .top, spacing: 8) {
      AsyncImage(url: URL(string: challenge.imageURL)) { image in
        image
          .resizable()
          .scaledToFill()
      } placeholder: {
        Assets.Images.placeholderImage.swiftUIImage
      }
      .frame(width: 76, height: 76)
      .clipShape(RoundedRectangle(cornerRadius: 16))

      VStack(alignment: .leading, spacing: 4) {
        Text(challenge.theme)
          .font(.captionL)
          .foregroundColor(Colors.gray200.swiftUIColor)
          .lineLimit(1)

        Text(challenge.name)
          .font(.bodyM)
          .foregroundColor(Colors.gray900.swiftUIColor)
          .lineLimit(1)
        
        HStack(spacing: 10) {
          HStack(spacing: 2) {
            Assets.Icons.heartFill.swiftUIImage
              .resizable()
              .foregroundColor(Colors.gray100.swiftUIColor)
              .frame(width: 16, height: 16)

            Text("\(challenge.places.count)")
              .font(.captionL)
              .foregroundColor(Colors.gray300.swiftUIColor)
          }
          
          HStack(spacing: 2) {
            Assets.Icons.locationFill.swiftUIImage
              .resizable()
              .foregroundColor(Colors.gray100.swiftUIColor)
              .frame(width: 16, height: 16)

            Text("\(challenge.places.count)")
              .font(.captionL)
              .foregroundColor(Colors.gray300.swiftUIColor)
          }
        }
        .padding(.top, 4)
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      VStack {
        Spacer()
        Button(action: {
          // TODO: 좋아요 토글 처리
        }) {
          Assets.Icons.heartFill.swiftUIImage
            .foregroundColor(.red)
            .frame(width: 19, height: 19)
        }
        .frame(width: 32, height: 32)
        .background(Colors.gray25.swiftUIColor)
        .cornerRadius(12)
        Spacer()
      }
      .padding(.trailing, 16)
    }
    .background(.clear)
    .frame(height: 76)
  }
}

// MARK: Preview

#Preview {
  MyPopListItemView(challenge: mockChallenges[0])
}

// MARK: - Helper
