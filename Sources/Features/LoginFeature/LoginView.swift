//
//  LoginView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/21/25.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import FacebookLogin
import Common
import GoogleSignIn
import GoogleSignInSwift
import FirebaseCore
import AuthenticationServices

struct LoginView: View {
  @State var store: StoreOf<LoginFeature>
  
  init(store: StoreOf<LoginFeature>) {
    self.store = store
  }
  
  var body: some View {
    VStack {
      GoogleSignInButton {
        store.send(.googleButtonTapped)
      }
      
      Button {
        store.send(.facebookButtonTapped)
      } label: {
        Text("페이스북 로그인")
          .fontWeight(.bold)
          .foregroundColor(.white)
          .padding(.vertical, 13)
          .padding(.horizontal, 95)
          .background(Color.blue)
          .cornerRadius(5)
      }
      
      SignInWithAppleButton(.signIn) { request in
        request.requestedScopes = []
      } onCompletion: { result in
        switch result {
        case .success(let authResults):
          store.send(.appleSignInCompleted(authResults))
        case .failure(let error):
          store.send(.appleSignInFailed(error.localizedDescription))
        }
      }
      .signInWithAppleButtonStyle(.black)
      .padding(.vertical, 13)
      .padding(.horizontal, 95)
      .frame(height: 44)
    }
    .padding()
    
  }
  
  func handleSignInButton() {
    guard let clientID = FirebaseApp.app()?.options.clientID else {
      logs.debug("❌ clientID 가져오기 실패")
      return
    }
    
    // 1. GIDConfiguration 준비
    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = config
    
    guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
    
    GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
      guard let result = signInResult else {
        return
      }
      print(result)
    }
  }
  
  func handleFacebookLogin() {
    let manager = LoginManager()
    
    manager.logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
      if let error = error {
        logs.debug("❌ Facebook 로그인 오류: \(error.localizedDescription)")
        return
      }
      
      guard let result = result, !result.isCancelled else {
        logs.debug("⛔️ 로그인 취소됨")
        return
      }
      
      // ✅ 로그인 성공 시 access token 획득
      if let token = AccessToken.current?.tokenString {
        logs.debug("📦 Facebook Access Token: \(token)")
        
        // 👉 여기서 token을 서버에 전달하거나, 사용자 정보 요청 등 처리
        // ex) AuthClient.loginWithFacebookToken(token)
      } else {
        logs.debug("⚠️ Access token을 가져올 수 없음")
      }
    }
  }
  
  func handleAppleAuth(credential: ASAuthorizationCredential) {
    guard let appleIDCredential = credential as? ASAuthorizationAppleIDCredential,
          let identityTokenData = appleIDCredential.identityToken,
          let identityToken = String(data: identityTokenData, encoding: .utf8) else {
      print("⚠️ Apple ID Credential or token missing")
      return
    }
    
    print("✅ identityToken: \(identityToken)")
    print("🧑‍💼 userID: \(appleIDCredential.user)")
    print("📧 email: \(appleIDCredential.email ?? "-")")
    
    // TODO: 서버에 identityToken 전달해서 인증 처리
  }
}

#Preview {
  LoginView(
    store: Store<LoginFeature.State, LoginFeature.Action>(
      initialState: .init(),
      reducer: { LoginFeature() }
    )
  )
}
