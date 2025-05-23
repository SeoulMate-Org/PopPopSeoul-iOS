//
//  ExpandableText.swift
//  Features
//
//  Created by suni on 5/14/25.
//

import SwiftUI
import Common
import SharedAssets

public struct ExpandableText: View {
  
  public init(text: String) {
    self.text = text
  }
  
  let text: String
  let lineLimit: Int = 3
  
  @State private var expanded: Bool = false
  @State private var isTruncated: Bool = false
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
        if isTruncated && !expanded {
            HStack(alignment: .bottom, spacing: 4) {
                Text(text)
                    .font(.captionL)
                    .foregroundColor(Colors.gray300.swiftUIColor)
                    .lineLimit(lineLimit)
                    .truncationMode(.tail)
                    .background(
                      TextSizeReader(text: text, font: .captionL, lineLimit: lineLimit) { truncated in
                        isTruncated = truncated
                      }
                        .frame(height: 0)
                        .hidden()
                    )

                Button(action: {
                    withAnimation {
                        expanded = true
                    }
                }) {
                    Assets.Icons.arrowUnderSmall.swiftUIImage
                        .resizable()
                        .foregroundColor(Colors.gray300.swiftUIColor)
                        .frame(width: 24, height: 24)
                }
            }
        } else {
            Text(text)
                .font(.captionL)
                .foregroundColor(Colors.gray300.swiftUIColor)
                .lineLimit(expanded ? nil : lineLimit)
                .background(
                  TextSizeReader(text: text, font: .captionL, lineLimit: lineLimit) { truncated in
                    isTruncated = truncated
                  }
                    .frame(height: 0)
                    .hidden()
                )

            if isTruncated && expanded {
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            expanded = false
                        }
                    }) {
                        Assets.Icons.arrowUpperSmall.swiftUIImage
                            .resizable()
                            .foregroundColor(Colors.gray300.swiftUIColor)
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
    }
  }
}

struct TextSizeReader: UIViewRepresentable {
  let text: String
  let font: UIFont
  let lineLimit: Int?
  let onUpdate: (Bool) -> Void
  
  func makeUIView(context: Context) -> UILabel {
    let label = UILabel()
    label.numberOfLines = 0
    label.lineBreakMode = .byTruncatingTail
    return label
  }
  
  func updateUIView(_ uiView: UILabel, context: Context) {
    uiView.text = text
    uiView.font = font
    uiView.numberOfLines = 0
    
    DispatchQueue.main.async {
      let fullSize = uiView.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 40, height: .greatestFiniteMagnitude))
      let fullHeight = fullSize.height
      
      uiView.numberOfLines = lineLimit ?? 0
      let limitedSize = uiView.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 40, height: .greatestFiniteMagnitude))
      let limitedHeight = limitedSize.height
      
      onUpdate(fullHeight > limitedHeight)
    }
  }
}
