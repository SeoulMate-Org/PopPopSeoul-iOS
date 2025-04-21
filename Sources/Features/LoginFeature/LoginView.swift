////
////  LoginView.swift
////  PopPopSeoulKit
////
////  Created by suni on 4/21/25.
////
//
//import SwiftUI
//import FacebookLogin
//import Common
//import GoogleSignIn
//import GoogleSignInSwift
//import FirebaseCore
//import FirebaseAuth
//import AuthenticationServices
//
//struct LoginView: View {
//  
//  var rootViewController: UIViewController? {
//    return UIApplication.shared.connectedScenes
//      .filter({ $0.activationState == .foregroundActive })
//      .compactMap { $0 as? UIWindowScene }
//      .compactMap { $0.keyWindow }
//      .first?.rootViewController
//  }
//  
//  var body: some View {
//    VStack {
//      GoogleSignInButton {
//        signInWithGoogle()
//      }
//      .padding(.vertical, 13)
//      .padding(.horizontal, 95)
//      .frame(height: 44)
//      
//      Button {
//        handleFacebookLogin()
//      } label: {
//        Text("페이스북 로그인")
//          .fontWeight(.bold)
//          .foregroundColor(.white)
//          .padding(.vertical, 13)
//          .padding(.horizontal, 95)
//          .background(Color.blue)
//          .cornerRadius(5)
//      }
//      
//      SignInWithAppleButton(.signIn) { request in
//        request.requestedScopes = [.fullName, .email]
//      } onCompletion: { result in
//        switch result {
//        case .success(let authResults):
//          handleAppleAuth(credential: authResults.credential)
//        case .failure(let error):
//          print("❌ Apple 로그인 실패: \(error.localizedDescription)")
//        }
//      }
//      .signInWithAppleButtonStyle(.black)
//      .padding(.vertical, 13)
//      .padding(.horizontal, 95)
//      .frame(height: 44)
//    }
//    .padding()
//    
//  }
//  
//  func signInWithGoogle() {
//    guard let clientID = FirebaseApp.app()?.options.clientID else {
//      logs.debug("❌ clientID 가져오기 실패")
//      return
//    }
//
//    // 1. GIDConfiguration 준비
//    let config = GIDConfiguration(clientID: clientID)
//    GIDSignIn.sharedInstance.configuration = config
//
//    // 2. 현재 rootViewController 필요 (presenting용)
//    guard let rootViewController = self.rootViewController else {
//      logs.debug("❌ rootViewController 없음")
//      return
//    }
//
//    // 3. 로그인 시도
//    GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
//      guard result != nil else {
//        return
//      }
//    }
////    do {
////      let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
////
////      let user = signInResult.user
////      let idToken = user.idToken?.tokenString
////      let accessToken = user.accessToken.tokenString
////
////      logs.debug("✅ idToken: \(idToken ?? "")")
////      logs.debug("✅ accessToken: \(accessToken)")
////
////      // 4. Firebase 인증 연결 예시
////      if let idToken = idToken {
////        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
////        let authResult = try await Auth.auth().signIn(with: credential)
////
////        logs.debug("🔥 Firebase 로그인 완료: \(authResult.user.uid)")
////      }
////
////    } catch {
////      logs.debug("❌ 로그인 실패: \(error.localizedDescription)")
////    }
//  }
//  
//  func handleFacebookLogin() {
//    let manager = LoginManager()
//
//    manager.logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
//      if let error = error {
//        logs.debug("❌ Facebook 로그인 오류: \(error.localizedDescription)")
//        return
//      }
//
//      guard let result = result, !result.isCancelled else {
//        logs.debug("⛔️ 로그인 취소됨")
//        return
//      }
//
//      // ✅ 로그인 성공 시 access token 획득
//      if let token = AccessToken.current?.tokenString {
//        logs.debug("📦 Facebook Access Token: \(token)")
//
//        // 👉 여기서 token을 서버에 전달하거나, 사용자 정보 요청 등 처리
//        // ex) AuthClient.loginWithFacebookToken(token)
//      } else {
//        logs.debug("⚠️ Access token을 가져올 수 없음")
//      }
//    }
//  }
//  
//  func handleAppleAuth(credential: ASAuthorizationCredential) {
//    guard let appleIDCredential = credential as? ASAuthorizationAppleIDCredential,
//          let identityTokenData = appleIDCredential.identityToken,
//          let identityToken = String(data: identityTokenData, encoding: .utf8) else {
//      print("⚠️ Apple ID Credential or token missing")
//      return
//    }
//
//    print("✅ identityToken: \(identityToken)")
//    print("🧑‍💼 userID: \(appleIDCredential.user)")
//    print("📧 email: \(appleIDCredential.email ?? "-")")
//
//    // TODO: 서버에 identityToken 전달해서 인증 처리
//  }
//}
//
//#Preview {
//  LoginView()
//}
