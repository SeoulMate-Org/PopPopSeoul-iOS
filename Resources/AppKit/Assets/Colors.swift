// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Color {
  public static let black = ColorAsset(name: "Black")
  public static let blue100 = ColorAsset(name: "Blue100")
  public static let blue200 = ColorAsset(name: "Blue200")
  public static let blue300 = ColorAsset(name: "Blue300")
  public static let blue400 = ColorAsset(name: "Blue400")
  public static let blue50 = ColorAsset(name: "Blue50")
  public static let blue500 = ColorAsset(name: "Blue500")
  public static let blue600 = ColorAsset(name: "Blue600")
  public static let blue700 = ColorAsset(name: "Blue700")
  public static let blue800 = ColorAsset(name: "Blue800")
  public static let blue900 = ColorAsset(name: "Blue900")
  public static let gray100 = ColorAsset(name: "Gray100")
  public static let gray200 = ColorAsset(name: "Gray200")
  public static let gray25 = ColorAsset(name: "Gray25")
  public static let gray300 = ColorAsset(name: "Gray300")
  public static let gray400 = ColorAsset(name: "Gray400")
  public static let gray50 = ColorAsset(name: "Gray50")
  public static let gray500 = ColorAsset(name: "Gray500")
  public static let gray600 = ColorAsset(name: "Gray600")
  public static let gray700 = ColorAsset(name: "Gray700")
  public static let gray75 = ColorAsset(name: "Gray75")
  public static let gray800 = ColorAsset(name: "Gray800")
  public static let gray900 = ColorAsset(name: "Gray900")
  public static let opacityBlack20 = ColorAsset(name: "OpacityBlack20")
  public static let opacityBlack40 = ColorAsset(name: "OpacityBlack40")
  public static let opacityBlack80 = ColorAsset(name: "OpacityBlack80")
  public static let opacityBlue10 = ColorAsset(name: "OpacityBlue10")
  public static let opacityBlue20 = ColorAsset(name: "OpacityBlue20")
  public static let opacityBlue40 = ColorAsset(name: "OpacityBlue40")
  public static let opacityBlue5 = ColorAsset(name: "OpacityBlue5")
  public static let opacityBlue50 = ColorAsset(name: "OpacityBlue50")
  public static let opacityBlue80 = ColorAsset(name: "OpacityBlue80")
  public static let red500 = ColorAsset(name: "Red500")
  public static let trueBlack = ColorAsset(name: "TrueBlack")
  public static let trueWhite = ColorAsset(name: "TrueWhite")
  public static let white = ColorAsset(name: "White")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
