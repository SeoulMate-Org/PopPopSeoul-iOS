import Foundation
import ProjectDescription

public let version = "0.0.1"

public let deploymentTargetString = "17.0"
public let appDeploymentTargets: DeploymentTargets = .iOS(deploymentTargetString)
public let appDestinations: Destinations = [.iPhone, .iPad]

let isAppStore = Environment.isAppStore.getBoolean(default: false)
let additionalCondition = isAppStore ? "APPSTORE" : ""

let swiftlintScript: TargetScript = .pre(
    script: """
  if which swiftlint >/dev/null; then
    swiftlint
  else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
  fi
  """,
    name: "SwiftLint",
    basedOnDependencyAnalysis: false
)

let appInfoPlist: [String: Plist.Value] = {
    var base: [String: Plist.Value] = [
        "CFBundleShortVersionString": Plist.Value(stringLiteral: version),
        "UILaunchStoryboardName": "Launch Screen",
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": []
        ],
        "CFBundleDevelopmentRegion": "ko",
        "CFBundleLocalizations": [
            "ko",
            "en"
        ],
        "ITSAppUsesNonExemptEncryption": false,
        "UIUserInterfaceStyle": "Light",
        "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
        "UISupportedInterfaceOrientations~ipad": [
            "UIInterfaceOrientationPortrait",
            "UIInterfaceOrientationPortraitUpsideDown",
            "UIInterfaceOrientationLandscapeLeft",
            "UIInterfaceOrientationLandscapeRight"
        ],
        "UIAppFonts": [
            "Pretendard-Black.otf",
            "Pretendard-Bold.otf",
            "Pretendard-ExtraBold.otf",
            "Pretendard-ExtraLight.otf",
            "Pretendard-Light.otf",
            "Pretendard-Medium.otf",
            "Pretendard-Regular.otf",
            "Pretendard-SemiBold.otf",
            "Pretendard-Thin.otf",
            "SB 어그로OTF B.otf",
            "SB 어그로OTF L.otf",
            "SB 어그로OTF M.otf",
        ],
        "NSUserTrackingUsageDescription": "로그인을 위해 Apple 계정을 사용합니다.",
        "FacebookAdvertiserIDCollectionEnabled": false,
        "NSAppTransportSecurity": [
            "NSAllowsArbitraryLoads": true
        ],
        "NSLocationWhenInUseUsageDescription": "앱 사용 중 사용자의 위치를 확인하기 위해 필요합니다.",
        "NSLocationAlwaysAndWhenInUseUsageDescription": "앱이 백그라운드에서도 위치를 사용할 수 있도록 하기 위해 필요합니다.",
        // ✅ Facebook & Google 관련 설정
        "CFBundleURLTypes": [
            [
                "CFBundleURLSchemes": ["com.googleusercontent.apps.$(GOOGLE_CLIENT_ID)"]
            ],
            [
                "CFBundleURLSchemes": ["fb$(FACEBOOK_APP_ID)"]
            ]
        ],
        "FacebookAppID": "$(FACEBOOK_APP_ID)",
        "FacebookClientToken": "$(FACEBOOK_CLIENT_TOKEN)",
        "FacebookDisplayName": "PopPopSeoul",
        "GoogleSignIn": "$(GOOGLE_SIGN_IN)",
        "BASE_URL": "$(BASE_URL)",
        "TEST_BASE_URL": "$(TEST_BASE_URL)",
        "NAVER_CLIENT_ID": "$(NAVER_CLIENT_ID)",
        "NAVER_CLIENT_SECRET": "$(NAVER_CLIENT_SECRET)",
        "NMFNcpKeyId": "$(NAVER_CLIENT_ID)"
    ]
    return base
    
    //    let secretsPath = "App/Resources/Secrets.plist"
    //    if let data = try? Data(contentsOf: URL(fileURLWithPath: secretsPath)),
    //       let secretsPlist = try? PropertyListSerialization.propertyList(
    //        from: data,
    //        options: [],
    //        format: nil
    //       ) as? [String: Any] {
    //
    //        let convertedSecrets = secretsPlist.compactMapValues { convertToPlistValue($0) }
    //        return base.merging(convertedSecrets) { $1 }
    //    } else {
    //        return base // ✅ fallback return!
    //    }
}()

func convertToPlistValue(_ any: Any) -> Plist.Value? {
    switch any {
    case let string as String:
        return .string(string)
    case let int as Int:
        return .integer(int)
    case let bool as Bool:
        return .boolean(bool)
    case let array as [Any]:
        return .array(array.compactMap { convertToPlistValue($0) })
    case let dict as [String: Any]:
        let converted = dict.compactMapValues { convertToPlistValue($0) }
        return .dictionary(converted)
    default:
        return nil
    }
}

func createAppTarget(suffix: String = "", isDev: Bool = false, scripts: [TargetScript] = [], dependencies: [TargetDependency] = []) -> Target {
    .target(
        name: "PopPopSeoul" + suffix,
        destinations: appDestinations,
        product: .app,
        bundleId: "dev.suni.poppopseoul",
        deploymentTargets: appDeploymentTargets,
        infoPlist: .extendingDefault(with: appInfoPlist),
        sources: "App/Sources/**",
        resources: .resources([
            "App/Resources/**",
            "Resources/AppKit/**"
        ]),
        entitlements: "PopPopSeoul.entitlements",
        scripts: scripts
        + [swiftlintScript],
        
        dependencies: [.target(name: "Features")]
        + dependencies,
        
        settings: .settings(
            base: [
                "CODE_SIGN_STYLE": "Automatic",
                "MARKETING_VERSION": SettingValue(stringLiteral: version),
                "CODE_SIGN_IDENTITY": "iPhone Developer",
                "CODE_SIGNING_REQUIRED": "YES",
                "OTHER_LDFLAGS": "-ObjC",
            ],
            debug: [
                "OTHER_SWIFT_FLAGS": "-D DEBUG $(inherited) -Xfrontend -warn-long-function-bodies=500 -Xfrontend -warn-long-expression-type-checking=500 -Xfrontend -debug-time-function-bodies -Xfrontend -debug-time-expression-type-checking -Xfrontend -enable-actor-data-race-checks",
                "OTHER_LDFLAGS": "-Xlinker -interposable $(inherited)",
                "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "\(additionalCondition) \(isDev ? "DEV" : "") DEBUG",
            ],
            release: [
                "OTHER_LDFLAGS": "$(inherited)",
                "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "\(additionalCondition) \(isDev ? "DEV" : "")",
            ]
        )
    )
}


let project = Project(
    name: "PopPopSeoul",
    options: .options(
        // localization 설정
        defaultKnownRegions: ["en", "ko"],
        developmentRegion: "ko",
        disableShowEnvironmentVarsInScriptPhases: true,
        textSettings: .textSettings(indentWidth: 2, tabWidth: 2)
    ),
    settings: .settings(
        base: [
            "GCC_TREAT_WARNINGS_AS_ERRORS": "YES",
            "SWIFT_TREAT_WARNINGS_AS_ERRORS": "YES",
            "IPHONEOS_DEPLOYMENT_TARGET": SettingValue(stringLiteral: deploymentTargetString),
            "ENABLE_BITCODE": "NO",
            "CODE_SIGN_IDENTITY": "",
            "CODE_SIGNING_REQUIRED": "NO",
            "DEVELOPMENT_LANGUAGE": "ko"
        ],
        configurations: [
            .debug(name: "Debug", xcconfig: .relativeToRoot("App/Resources/Secrets.xcconfig")),
            .release(name: "Release", xcconfig: .relativeToRoot("App/Resources/Secrets.xcconfig"))
        ]
    ),
    targets:
        
        // MARK: - App
    
    // Main Target
    [createAppTarget()]
    + (isAppStore
       ? []
       : [
        // Additional Dev target with various extra scripts and debug settings
        createAppTarget(
            suffix: "Dev",
            isDev: true,
            dependencies: []
        ),
        .target(
            name: "PopPopSeoulKitTests",
            destinations: appDestinations,
            product: .unitTests,
            bundleId: "dev.suni.poppopseoulkit.tests",
            infoPlist: .default,
            sources: "Tests/AppKit/**",
            dependencies: [
                .target(name: "Features")
            ]
        ),
        .target(
            name: "SharedAssets",
            destinations: appDestinations,
            product: .staticFramework,
            bundleId: "dev.sunidev.poppopseoul.sharedassets",
            infoPlist: .default,
            sources: "Sources/SharedAssets/**",
            resources: .resources([
                "App/Resources/**",
                "Resources/AppKit/**"
            ]),
            dependencies: [ ]
        ),
        .target(
            name: "SharedTypes",
            destinations: appDestinations,
            product: .staticFramework,
            bundleId: "dev.sunidev.poppopseoul.sharedtypes",
            infoPlist: .default,
            sources: "Sources/SharedTypes/**",
            resources: .resources([
                "App/Resources/**",
                "Resources/AppKit/**"
            ]),
            dependencies: [ ]
        ),
        .target(
            name: "Common",
            destinations: appDestinations,
            product: .staticFramework,
            bundleId: "dev.sunidev.poppopseoul.common",
            infoPlist: .default,
            sources: "Sources/Common/**",
            resources: .resources([
                "App/Resources/**",
                "Resources/AppKit/**"
            ]),
            dependencies: [
                .target(name: "SharedAssets"),
                .target(name: "SharedTypes"),
            ]
        ),
        .target(
            name: "Models",
            destinations: appDestinations,
            product: .staticFramework,
            bundleId: "dev.sunidev.poppopseoul.models",
            infoPlist: .default,
            sources: "Sources/Models/**",
            resources: .resources([
                "App/Resources/**",
                "Resources/AppKit/**"
            ]),
            dependencies: [
                .external(name: "ComposableCoreLocation"),
                .target(name: "SharedTypes"),
                .target(name: "SharedAssets"),
                .target(name: "Common"),
            ]
        ),
        .target(
            name: "DesignSystem",
            destinations: appDestinations,
            product: Environment.forPreview.getBoolean(default: false) ? .framework : .staticFramework,
            bundleId: "dev.sunidev.poppopseoul.clients",
            infoPlist: .default,
            sources: "Sources/DesignSystem/**",
            resources: .resources([
                "App/Resources/**",
                "Resources/AppKit/**"
            ]),
            dependencies: [
                .external(name: "Kingfisher"),
                .target(name: "SharedTypes"),
                .target(name: "SharedAssets"),
                .target(name: "Common"),
                .target(name: "Models"),
            ]
        ),
        .target(
            name: "Clients",
            destinations: appDestinations,
            product: .staticFramework,
            bundleId: "dev.sunidev.poppopseoul.clients",
            infoPlist: .default,
            sources: "Sources/Clients/**",
            resources: .resources([
                "App/Resources/**",
                "Resources/AppKit/**"
            ]),
            dependencies: [
                .external(name: "ComposableArchitecture"),
                .external(name: "ComposableCoreLocation"),
                .external(name: "FirebaseRemoteConfig"),
                .external(name: "FirebaseAnalytics"),
                .target(name: "Common"),
                .target(name: "Models"),
            ]
        ),
        .target(
            name: "Features",
            destinations: appDestinations,
            product: Environment.forPreview.getBoolean(default: false) ? .framework : .staticFramework,
            bundleId: "dev.suni.poppopseoul.features",
            deploymentTargets: appDeploymentTargets,
            infoPlist: .extendingDefault(with: [:]),
            sources: "Sources/Features/**",
            resources: .resources([
                "App/Resources/**",
                "Resources/AppKit/**"
            ]),
            dependencies: [
                .external(name: "ComposableArchitecture"),
                .external(name: "ComposableCoreLocation"),
                .external(name: "NMapsMap"),
                .external(name: "FacebookLogin"),
                .external(name: "GoogleSignIn"),
                .external(name: "GoogleSignInSwift"),
                .external(name: "FirebaseAuth"),
                .external(name: "Kingfisher"),
                .target(name: "Clients"),
                .target(name: "Models"),
                .target(name: "DesignSystem"),
                .target(name: "SharedTypes"),
                .target(name: "SharedAssets"),
                .target(name: "Common"),
            ]
        )
       ]
      )
)
