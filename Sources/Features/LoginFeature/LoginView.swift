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
  let store: StoreOf<LoginFeature>
  
  init(store: StoreOf<LoginFeature>) {
    self.store = store
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
        if store.isInit {
          HStack {
            Spacer()
            Button {
              store.send(.aroundTapped)
            } label: {
              Text(L10n.textButton_browse)
                .font(.bodyS)
                .foregroundColor(Colors.appWhite.swiftUIColor)
                .padding(8)
            }
            .padding(.trailing, 12)
            .padding(.top, Utility.safeTop + 5)
          }
        } else {
          HStack {
            Button {
              store.send(.backTapped)
            } label: {
              Assets.Icons.arrowLeftLine.swiftUIImage
                .foregroundColor(Colors.appWhite.swiftUIColor)
                .frame(width: 24, height: 24)
            }
            .frame(width: 40, height: 40)
            .padding(.leading, 8)
            Spacer()
          }
          .padding(.top, Utility.safeTop)
        }
        
        Spacer()
        
        // FIXME: - 1차 오픈 히든
        //        LoginButtonView(
        //          image: Assets.Icons.facebook.swiftUIImage,
        //          text: L10n.signIn_facebook,
        //          onTap: {
        //            handleFacebookLogin()
        //          }, isLight: false
        //        )
        LoginButtonView(
          image: Assets.Icons.google.swiftUIImage,
          text: L10n.signIn_google,
          onTap: {
            handleGoogleSignInButton()
          }, isLight: false
        )
        
        ZStack {
          SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.fullName, .email]
          } onCompletion: { result in
            switch result {
            case .success(let authResults):
              handleAppleAuth(credential: authResults.credential)
            case .failure(let error):
              logger.error("❌ Apple 로그인 실패: \(error.localizedDescription)")
              store.send(.loginError)
            }
          }
          .blendMode(.overlay)
          .frame(maxWidth: .infinity)
          .frame(height: 52)
          .cornerRadius(8)
          .padding(.horizontal, 35)
          
          LoginButtonView(
            image: Assets.Icons.apple.swiftUIImage,
            text: L10n.signIn_apple,
            onTap: nil, isLight: true
          )
          .allowsHitTesting(false)
        }
      }
      .frame(width: Utility.screenWidth)
      .padding(.bottom, Utility.safeBottom + 48)
    }
    .ignoresSafeArea()
    .navigationBarBackButtonHidden(true)
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
        //        store.send(.facebookSignInCompleted(token))
        fetchFacebookUserInfo(withToken: token)
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
      if let error = error {
        logger.error("\(String(describing: error))")
        store.send(.loginError)
        return
      }
      
      if let result = result as? [String: Any] {
        if let email = result["email"] as? String {
          store.send(.facebookSignInCompleted(email))
          return
        } else if let id = result["id"] as? String {
          store.send(.facebookSignInCompleted(id))
          return
        }
      }
      store.send(.loginError)
    }
  }
  
  func handleAppleAuth(credential: ASAuthorizationCredential) {
    guard let appleIDCredential = credential as? ASAuthorizationAppleIDCredential,
          let identityTokenData = appleIDCredential.identityToken,
          let identityToken = String(data: identityTokenData, encoding: .utf8) else {
      store.send(.loginError)
      return
    }
    
    store.send(.appleSignInCompleted(identityToken))
  }
}

// MARK: - Preview

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
