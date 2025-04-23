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
import FBSDKCoreKit

struct LoginView: View {
  @State var store: StoreOf<LoginFeature>
  
  init(store: StoreOf<LoginFeature>) {
    self.store = store
  }
  
  var body: some View {
    VStack {
      GoogleSignInButton {
        handleGoogleSignInButton()
      }
      
      Button {
        handleFacebookLogin()
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
        request.requestedScopes = [.email]
      } onCompletion: { result in
        switch result {
        case .success(let authResults):
          handleAppleAuth(credential: authResults.credential)
        case .failure:
          store.send(.loginError)
        }
      }
      .signInWithAppleButtonStyle(.black)
      .padding(.vertical, 13)
      .padding(.horizontal, 95)
      .frame(height: 44)
    }
    .padding()
    
  }
  
  func handleGoogleSignInButton() {
    guard let clientID = FirebaseApp.app()?.options.clientID else {
      logs.debug("❌ clientID 가져오기 실패")
      store.send(.loginError)
      return
    }
    
    // 1. GIDConfiguration 준비
    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = config
    
    guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
    
    GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
      guard let result = signInResult, let token = result.user.idToken?.tokenString else {
        logs.debug("❌ Google 로그인 오류: \(error?.localizedDescription ?? "")")
        store.send(.loginError)
        return
      }
      
      store.send(.googleSignInCompleted(token))
    }
  }
  
  func handleFacebookLogin() {
    let manager = LoginManager()
    
    manager.logOut()
    
    manager.logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
      if let error = error {
        logs.debug("❌ Facebook 로그인 오류: \(error.localizedDescription)")
        store.send(.loginError)
        return
      }
      
      guard let result = result, !result.isCancelled else {
        logs.debug("⛔️ 로그인 취소됨")
        store.send(.loginError)
        return
      }
      
      // ✅ 로그인 성공 시 access token 획득
      if let token = AuthenticationToken.current?.tokenString {
        print("📌 Facebook token: \(token)")
        store.send(.facebookSignInCompleted(token))
      } else {
        logs.debug("⚠️ Access token을 가져올 수 없음")
        store.send(.loginError)
      }
    }
  }
  
  func fetchFacebookUserInfo(withToken token: String) {
    let graphRequest = GraphRequest(graphPath: "me",
                                    parameters: ["fields": "id, name, email"],
                                    tokenString: token,
                                    version: nil,
                                    httpMethod: .get)
    
    print("📌 Facebook token: \(token)")
    graphRequest.start { _, result, error in
      if let error = error {
        print("❌ 사용자 정보 요청 실패: \(error.localizedDescription)")
        return
      }
      
      if let result = result as? [String: Any] {
        let id = result["id"] as? String ?? "-"
        let name = result["name"] as? String ?? "-"
        let email = result["email"] as? String ?? "-"
        
        print("📌 Facebook ID: \(id)")
        print("👤 이름: \(name)")
        print("📧 이메일: \(email)")
      }
    }
  }
  
  func handleAppleAuth(credential: ASAuthorizationCredential) {
    guard let appleIDCredential = credential as? ASAuthorizationAppleIDCredential,
          let identityTokenData = appleIDCredential.identityToken,
          let identityToken = String(data: identityTokenData, encoding: .utf8) else {
      print("⚠️ Apple ID Credential or token missing")
      store.send(.loginError)
      return
    }
    
    print("✅ identityToken: \(identityToken)")
    print("🧑‍💼 userID: \(appleIDCredential.user)")
    print("📧 email: \(appleIDCredential.email ?? "-")")
    
    store.send(.appleSignInCompleted(identityToken))
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

extension LoginManager {
    func isLimitedLogin() -> Bool {
        return _DomainHandler.sharedInstance().isDomainHandlingEnabled() && !Settings.shared.isAdvertiserTrackingEnabled
    }
}
