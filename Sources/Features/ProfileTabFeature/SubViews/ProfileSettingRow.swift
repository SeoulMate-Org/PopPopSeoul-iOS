//
//  ProfileSettingRow.swift
//  Features
//
//  Created by suni on 5/2/25.
//

import SwiftUI
import DesignSystem
import SharedAssets

public struct SettingRowView<Trailing: View>: View {
  let title: String
  let subTitle: String?
  let trailing: () -> Trailing

  public init(
    title: String,
    subTitle: String? = nil,
    @ViewBuilder trailing: @escaping () -> Trailing
  ) {
    self.title = title
    self.subTitle = subTitle
    self.trailing = trailing
  }

  public var body: some View {
    HStack {
      HStack(spacing: 4) {
        Text(title)
          .font(.bodyM)
          .foregroundStyle(Colors.gray900.swiftUIColor)

        if let sub = subTitle {
          Text(sub)
            .font(.captionM)
            .foregroundStyle(Colors.gray400.swiftUIColor)
        }
      }

      Spacer()

      trailing()
    }
    .frame(height: 40)
  }
}
