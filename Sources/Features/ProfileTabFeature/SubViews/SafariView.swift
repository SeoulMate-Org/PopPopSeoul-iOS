//
//  SafariView.swift
//  DesignSystem
//
//  Created by suni on 5/2/25.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
  let url: URL

  func makeUIViewController(context: Context) -> SFSafariViewController {
    let safariVC = SFSafariViewController(url: url)
    safariVC.dismissButtonStyle = .close
    return safariVC
  }
  
  func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) { }
}
