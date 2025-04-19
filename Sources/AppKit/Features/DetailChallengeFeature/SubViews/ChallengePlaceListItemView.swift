//
//  ChallengePlaceListItemView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/20/25.
//

import SwiftUI

struct ChallengePlaceListItemView: View {
  let place: Place
  let onLikeTapped: () -> Void
  
  var body: some View {
    HStack(alignment: .center, spacing: 8) {
      AsyncImage(url: URL(string: place.imageURL)) { image in
        image
          .resizable()
          .scaledToFill()
      } placeholder: {
        Assets.Images.placeholderImage.swiftUIImage
          .resizable()
          .scaledToFill()
      }
      .frame(width: 76, height: 76)
      .clipShape(RoundedRectangle(cornerRadius: 16))
      
      VStack(alignment: .leading, spacing: 4) {
        Text(place.name)
          .font(.bodyM)
          .foregroundColor(Colors.gray900.swiftUIColor)
          .lineLimit(2)
        
        HStack(spacing: 6) {
          
          if place.likeCount > 0 {
            HStack(spacing: 2) {
              Assets.Icons.heartFill.swiftUIImage
                .resizable()
                .foregroundColor(Colors.gray100.swiftUIColor)
                .frame(width: 16, height: 16)
              
              Text("\(place.likeCount)")
                .font(.captionL)
                .foregroundColor(Colors.gray300.swiftUIColor)
            }
          }
          
          if place.participantCount > 0 {
            HStack(spacing: 2) {
              Assets.Icons.profileFill.swiftUIImage
                .resizable()
                .foregroundColor(Colors.gray100.swiftUIColor)
                .frame(width: 16, height: 16)
              
              Text("\(place.participantCount)")
                .font(.captionL)
                .foregroundColor(Colors.gray300.swiftUIColor)
            }
          }
        }
        
        HStack(spacing: 4) {
          Assets.Icons.route.swiftUIImage
            .resizable()
            .foregroundColor(Colors.gray100.swiftUIColor)
            .frame(width: 16, height: 16)

          Text("나로부터 2.9km")
            .font(.captionL)
            .foregroundColor(Colors.gray400.swiftUIColor)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      VStack {
        Spacer()
        Button(action: {
          onLikeTapped()
        }) {
          if place.isLike {
            Assets.Icons.heartFill.swiftUIImage
              .foregroundColor(Colors.red500.swiftUIColor)
              .frame(width: 24, height: 24)
          } else {
            Assets.Icons.heartLine.swiftUIImage
              .foregroundColor(Colors.gray200.swiftUIColor)
              .frame(width: 24, height: 24)
          }
        }
        .frame(width: 40, height: 40)
        .background(Colors.gray25.swiftUIColor)
        .cornerRadius(16)
        Spacer()
      }
      .padding(.leading, 16)
    }
    .background(.clear)
    .frame(height: 101)
  }
}

#Preview {
  ChallengePlaceListItemView(place: mockPlace1, onLikeTapped: { })
}
