//
//  LoginView.swift
//  PopPopSeoulKit
//
//  Created by suni on 4/21/25.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import Common
import SharedAssets
import FacebookLogin
import GoogleSignIn
import GoogleSignInSwift
import FirebaseCore
import AuthenticationServices
import FBSDKCoreKit

struct LoginView: View {
  @State var store: StoreOf<LoginFeature>
  let isShowBack: Bool
  
  init(store: StoreOf<LoginFeature>, isShowBack: Bool) {
    self.store = store
    self.isShowBack = isShowBack
  }
  
  var body: some View {
    ZStack(alignment: .top) {
      
      let backWidht = Utility.screenWidth * (485.88 / 375)
      let backHeight = backWidht * (431.79 / 485.88)
      
      LinearGradient.blutFadeLeftToRight
      
      Assets.Images.loginLogo.swiftUIImage
        .resizable()
        .scaledToFit()
        .frame(width: backWidht, height: backHeight)
        .padding(.top, Utility.safeTop)
      
      VStack(spacing: 10) {
        if isShowBack {
          HStack {
            Button {
              store.send(.backTapped)
            } label: {
              Image(systemName: "chevron.left")
                .foregroundColor(.black)
            }
            .padding(.top, 5)
            .padding(.trailing, 12)
          }
          Spacer()
        } else {
          HStack {
            Spacer()
            Button {
              store.send(.aroundTapped)
            } label: {
              Text("둘러보기")
                .font(.bodyS)
                .foregroundColor(Colors.appWhite.swiftUIColor)
                .padding(8)
            }
            .padding(.trailing, 12)
            .padding(.top, Utility.safeTop + 5)
          }
        }
        
        Spacer()
        
        LoginButtonView(
          image: Assets.Icons.facebook.swiftUIImage,
          text: "페이스북으로 계속하기",
          onTap: {
            handleFacebookLogin()
          }, isLight: false
        )
        LoginButtonView(
          image: Assets.Icons.google.swiftUIImage,
          text: "구글로 계속하기",
          onTap: {
            handleGoogleSignInButton()
          }, isLight: false
        )
        LoginButtonView(
          image: Assets.Icons.apple.swiftUIImage,
          text: "애플로 계속하기",
          onTap: {
            let coordinator = AppleSignInCoordinator()
            coordinator.onSuccess = { appleIDCredential in
              handleAppleAuth(appleIDCredential: appleIDCredential)
            }
            coordinator.onFailure = {
              store.send(.loginError)
            }
            coordinator.startSignInWithAppleFlow()
          }, isLight: true
        )
      }
      .frame(width: Utility.screenWidth)
      .padding(.bottom, Utility.safeBottom + 48)
    }
    .ignoresSafeArea()
  }
  
  func handleGoogleSignInButton() {
    guard let clientID = FirebaseApp.app()?.options.clientID else {
      store.send(.loginError)
      return
    }
    
    // 1. GIDConfiguration 준비
    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = config
    
    guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
    
    GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, _ in
      guard let result = signInResult, let token = result.user.idToken?.tokenString else {
        store.send(.loginError)
        return
      }
      
      store.send(.googleSignInCompleted(token))
    }
  }
  
  func handleFacebookLogin() {
    let manager = LoginManager()
    
    manager.logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
      if let error = error {
        print(error)
        store.send(.loginError)
        return
      }
      
      guard let result = result, !result.isCancelled else {
        store.send(.loginError)
        return
      }
      
      // ✅ 로그인 성공 시 access token 획득
      if let token = AuthenticationToken.current?.tokenString {
        store.send(.facebookSignInCompleted(token))
      } else {
        store.send(.loginError)
      }
    }
  }
  
  func fetchFacebookUserInfo(withToken token: String) {
    let graphRequest = GraphRequest(
      graphPath: "me",
      parameters: ["fields": "id, name, email"],
      tokenString: token,
      version: nil,
      httpMethod: .get
    )
    graphRequest.start { _, result, error in
      print("\(String(describing: result)) \(String(describing: error))")
      //      if let error = error {
      //        return
      //      }
      //
      //      if let result = result as? [String: Any] {
      //        let id = result["id"] as? String ?? "-"
      //        let name = result["name"] as? String ?? "-"
      //        let email = result["email"] as? String ?? "-"
      //      }
    }
  }
  
  func handleAppleAuth(appleIDCredential: ASAuthorizationAppleIDCredential) {
    guard let identityTokenData = appleIDCredential.identityToken,
          let identityToken = String(data: identityTokenData, encoding: .utf8) else {
      store.send(.loginError)
      return
    }
    
    store.send(.appleSignInCompleted(identityToken))
  }
}

// MARK: - Preview

#Preview {
  LoginView(
    store: Store<LoginFeature.State, LoginFeature.Action>(
      initialState: .init(),
      reducer: { LoginFeature() }
    ),
    isShowBack: false
  )
}

// MARK: - Helper

extension LoginManager {
  func isLimitedLogin() -> Bool {
    return _DomainHandler.sharedInstance().isDomainHandlingEnabled() && !Settings.shared.isAdvertiserTrackingEnabled
  }
}

final class AppleSignInCoordinator: NSObject {
  var onSuccess: ((ASAuthorizationAppleIDCredential) -> Void)?
  var onFailure: (() -> Void)?
  
  func startSignInWithAppleFlow() {
    let request = ASAuthorizationAppleIDProvider().createRequest()
    request.requestedScopes = [.email]
    
    let controller = ASAuthorizationController(authorizationRequests: [request])
    controller.delegate = self
    controller.presentationContextProvider = self
    controller.performRequests()
  }
}

extension AppleSignInCoordinator: ASAuthorizationControllerDelegate {
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
      onSuccess?(credential)
    } else {
      onFailure?()
    }
  }
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    onFailure?()
  }
}

extension AppleSignInCoordinator: ASAuthorizationControllerPresentationContextProviding {
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return UIApplication.shared
      .connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first { $0.isKeyWindow } ?? ASPresentationAnchor()
  }
}
