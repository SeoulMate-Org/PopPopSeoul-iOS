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
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Assets {
  public enum Icons {
    public static let apple = ImageAsset(name: "apple")
    public static let appleProfile = ImageAsset(name: "apple_profile")
    public static let arrowLeftLine = ImageAsset(name: "arrow_left_line")
    public static let arrowRightLine = ImageAsset(name: "arrow_right_line")
    public static let arrowRightSmall = ImageAsset(name: "arrow_right_small")
    public static let arrowUnderSmall = ImageAsset(name: "arrow_under_small")
    public static let arrowUpperLine = ImageAsset(name: "arrow_upper_line")
    public static let arrowUpperSmall = ImageAsset(name: "arrow_upper_small")
    public static let callFill = ImageAsset(name: "call_fill")
    public static let callLine = ImageAsset(name: "call_line")
    public static let checkLine = ImageAsset(name: "check_line")
    public static let commentFill = ImageAsset(name: "comment_fill")
    public static let commentLine = ImageAsset(name: "comment_line")
    public static let deleteBtnLine = ImageAsset(name: "delete_btn_line")
    public static let embassyLine = ImageAsset(name: "embassy_line")
    public static let emptyLine = ImageAsset(name: "empty_line")
    public static let facebook = ImageAsset(name: "facebook")
    public static let facebookProfile = ImageAsset(name: "facebook_profile")
    public static let google = ImageAsset(name: "google")
    public static let googleProfile = ImageAsset(name: "google_profile")
    public static let heartFill = ImageAsset(name: "heart_fill")
    public static let heartLine = ImageAsset(name: "heart_line")
    public static let homeFill = ImageAsset(name: "home_fill")
    public static let homeLine = ImageAsset(name: "home_line")
    public static let hospitalLine = ImageAsset(name: "hospital_line")
    public static let locationFill = ImageAsset(name: "location_fill")
    public static let locationLine = ImageAsset(name: "location_line")
    public static let mapFill = ImageAsset(name: "map_fill")
    public static let mapLine = ImageAsset(name: "map_line")
    public static let more = ImageAsset(name: "more")
    public static let popFill = ImageAsset(name: "pop_fill")
    public static let popLine = ImageAsset(name: "pop_line")
    public static let profileFill = ImageAsset(name: "profile_fill")
    public static let profileLine = ImageAsset(name: "profile_line")
    public static let route = ImageAsset(name: "route")
    public static let searchLine = ImageAsset(name: "search_line")
    public static let shareLine = ImageAsset(name: "share_line")
    public static let subwayFill = ImageAsset(name: "subway_fill")
    public static let subwayLine = ImageAsset(name: "subway_line")
    public static let themeFill = ImageAsset(name: "theme_fill")
    public static let themeLine = ImageAsset(name: "theme_line")
    public static let toiletLine = ImageAsset(name: "toilet_line")
    public static let warningLine = ImageAsset(name: "warning_line")
    public static let webLine = ImageAsset(name: "web_line")
    public static let wifiLine = ImageAsset(name: "wifi_line")
    public static let writeLine = ImageAsset(name: "write_line")
    public static let xLine = ImageAsset(name: "x_line")
  }
  public enum Images {
    public static let logoDark = ImageAsset(name: "Logo_dark")
    public static let logoLight = ImageAsset(name: "Logo_light")
    public static let badgeCulturalEvent = ImageAsset(name: "badge_culturalEvent")
    public static let badgeCulturalEventDis = ImageAsset(name: "badge_culturalEvent_dis")
    public static let badgeExhibitionArt = ImageAsset(name: "badge_exhibitionArt")
    public static let badgeExhibitionArtDis = ImageAsset(name: "badge_exhibitionArt_dis")
    public static let badgeFoodieHiddenGemes = ImageAsset(name: "badge_foodieHiddenGemes")
    public static let badgeFoodieHiddenGemesDis = ImageAsset(name: "badge_foodieHiddenGemes_dis")
    public static let badgeHistoryCulture = ImageAsset(name: "badge_historyCulture")
    public static let badgeHistoryCultureDis = ImageAsset(name: "badge_historyCulture_dis")
    public static let badgeLocalTour = ImageAsset(name: "badge_localTour")
    public static let badgeLocalTourDis = ImageAsset(name: "badge_localTour_dis")
    public static let badgeMustSeeSpots = ImageAsset(name: "badge_mustSeeSpots")
    public static let badgeMustSeeSpotsDis = ImageAsset(name: "badge_mustSeeSpots_dis")
    public static let badgeNightViewsMood = ImageAsset(name: "badge_nightViewsMood")
    public static let badgeNightViewsMoodDis = ImageAsset(name: "badge_nightViewsMood_dis")
    public static let badgePhotoSpot = ImageAsset(name: "badge_photoSpot")
    public static let badgePhotoSpotDis = ImageAsset(name: "badge_photoSpot_dis")
    public static let badgeWalkingTour = ImageAsset(name: "badge_walkingTour")
    public static let badgeWalkingTourDis = ImageAsset(name: "badge_walkingTour_dis")
    public static let completeChallenge = ImageAsset(name: "complete_challenge")
    public static let emptyPop = ImageAsset(name: "empty_pop")
    public static let errorImage = ImageAsset(name: "error_image")
    public static let homeBanner = ImageAsset(name: "home_banner")
    public static let homeMissing = ImageAsset(name: "home_missing")
    public static let homePrompt = ImageAsset(name: "home_prompt")
    public static let launchLogo = ImageAsset(name: "launch_logo")
    public static let loginLogo = ImageAsset(name: "login_logo")
    public static let mybadgePrompt = ImageAsset(name: "mybadge_prompt")
    public static let placeholderImage = ImageAsset(name: "placeholder_image")
    public static let splashBack = ImageAsset(name: "splash_back")
    public static let splashBackground = ImageAsset(name: "splash_background")
    public static let splashBottom = ImageAsset(name: "splash_bottom")
    public static let splashLogo = ImageAsset(name: "splash_logo")
    public static let splashTop = ImageAsset(name: "splash_top")
    public static let stampInactive = ImageAsset(name: "stamp inactive")
    public static let stampActive = ImageAsset(name: "stamp_active")
    public static let themePromptLogin = ImageAsset(name: "theme_prompt_login")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  public func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
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
