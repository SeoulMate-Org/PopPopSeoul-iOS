//
//  LoginView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/21/25.
//

import SwiftUI
import FacebookLogin
import Common

struct LoginView: View {
    var body: some View {
      VStack {
          // 2. 버튼 생성
          Button {
              // 2-1. 필수 구현 부분 (필요 시, permissions을 더 추가할 수 있음)
              LoginManager().logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
                  // 로그인 버튼 눌렀을 때 수행할 코드 여기에 작성 (아래 코드 자유롭게 수정!)
                  if let error = error {
                      // 로그인 창이 뜨지 않는 등 에러가 발생한 경우
                    logs.debug("Encountered Error: \(error)")
                  } else if let result = result, result.isCancelled {
                      // 로그인 창이 떴지만, 사용자가 취소를 한 경우
                    logs.debug("Cancelled")
                  } else {
                      // 로그인 창이 뜨고, 사용자가 로그인에 성공한 경우
                    logs.debug("Logged In")
                  }
              }
          } label: {
              Text("페이스북 로그인")
                  .fontWeight(.bold)
                  .foregroundColor(.white)
                  .padding(.vertical, 13)
                  .padding(.horizontal, 95)
                  .background(Color.blue)
                  .cornerRadius(5)
          }
      }
      .padding()
    }
}

#Preview {
    LoginView()
}
