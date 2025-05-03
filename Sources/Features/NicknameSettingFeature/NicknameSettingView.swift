//
//  NicknameSettingView.swift
//  Features
//
//  Created by suni on 5/3/25.
//

import SwiftUI
import ComposableArchitecture
import Common
import DesignSystem
import SharedAssets
import SharedTypes
import Models

struct NicknameSettingView: View {
  let store: StoreOf<NicknameSettingFeature>
  @ObservedObject var viewStore: ViewStore<NicknameSettingFeature.State, NicknameSettingFeature.Action>
  
  init(store: StoreOf<NicknameSettingFeature>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
    VStack(spacing: 0) {
      HeaderView(type: .back(title: "닉네임 변경", onBack: {
        viewStore.send(.tappedBack)
      }))
      
      textfield()
        .padding(.top, 49)
      
      Spacer()
      
      if viewStore.textfieldStatus == .good {
        Button(action: {
          viewStore.send(.tappedSave)
        }) {
          Text(L10n.myTapButtonText_completed)
            .font(.buttonM)
            .foregroundColor(Colors.appWhite.swiftUIColor)
            .frame(maxWidth: .infinity, minHeight: 51)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .background(Colors.blue500.swiftUIColor)
        .cornerRadius(15)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
      } else {
        Button(action: { }) {
          Text(L10n.myTapButtonText_completed)
            .font(.buttonM)
            .foregroundColor(Colors.blue300.swiftUIColor)
            .frame(maxWidth: .infinity, minHeight: 51)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .background(Colors.blue100.swiftUIColor)
        .cornerRadius(15)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
      }
    }
    .background(Colors.appWhite.swiftUIColor)
    .onAppear {
      viewStore.send(.onAppear)
    }
    .navigationBarBackButtonHidden(true)
  }
  
  @ViewBuilder
  private func textfield() -> some View {
    VStack(alignment: .leading, spacing: 10) {
      ZStack(alignment: .trailing) {
        TextField("", text: viewStore.binding(
          get: \.inputText,
          send: NicknameSettingFeature.Action.inputTextChanged
        ))
        .padding(.horizontal, 16)
        .frame(height: 48)
        .background(
          RoundedRectangle(cornerRadius: 10)
            .fill(Colors.gray25.swiftUIColor)
        )
        .overlay(
          RoundedRectangle(cornerRadius: 10)
            .stroke(viewStore.textfieldStatus.strokeColor, lineWidth: 1)
        )

        // X 버튼
        Button(action: {
          viewStore.send(.inputTextChanged(""))
        }) {
          Assets.Icons.xLine.swiftUIImage
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundStyle(Colors.gray600.swiftUIColor)
            .padding(.trailing, 12)
            .padding(.vertical, 12)
        }
      }

      // Hint 텍스트
      Text(viewStore.textfieldStatus.hint)
        .font(.captionM)
        .foregroundStyle(viewStore.textfieldStatus.strokeColor)
        .padding(.horizontal, 16)
    }
    .padding(.horizontal, 20)
  }

}

extension NicknameSettingFeature.TextFieldStatus {
  var strokeColor: Color {
    switch self {
    case .none:
      Colors.gray300.swiftUIColor
    case .good:
      Colors.blue500.swiftUIColor
    case .error, .duplication:
      Colors.red500.swiftUIColor
    }
  }
  
  var hint: String {
    switch self {
    case .none, .good, .error:
      "닉네임을 2~15자로 입력해주세요."
    case .duplication:
      "사용 중인 닉네임입니다."
    }
  }
}
