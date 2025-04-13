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

let appInfoPlist: [String: Plist.Value] = [
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
    ]
]

func createAppTarget(suffix: String = "", isDev: Bool = false, scripts: [TargetScript] = [], dependencies: [TargetDependency] = []) -> Target {
    .target(
        name: "PopPopSeoul" + suffix,
        destinations: appDestinations,
        product: .app,
        bundleId: "dev.suni.PopPopSeoul",
        deploymentTargets: appDeploymentTargets,
        infoPlist: .extendingDefault(with: appInfoPlist),
        sources: "App/Sources/**",
        resources: .resources([
            "App/Resources/**",
            "Resources/AppKit/**"
        ]),
        scripts: scripts
        + [swiftlintScript],
        
        dependencies: [.target(name: "PopPopSeoulKit")]
        + dependencies,
        
        settings: .settings(
            base: [
                "CODE_SIGN_STYLE": "Automatic",
                "MARKETING_VERSION": SettingValue(stringLiteral: version),
                "CODE_SIGN_IDENTITY": "iPhone Developer",
                "CODE_SIGNING_REQUIRED": "YES",
            ],
            debug: [
                "OTHER_SWIFT_FLAGS": "-D DEBUG $(inherited) -Xfrontend -warn-long-function-bodies=500 -Xfrontend -warn-long-expression-type-checking=500 -Xfrontend -debug-time-function-bodies -Xfrontend -debug-time-expression-type-checking -Xfrontend -enable-actor-data-race-checks",
                "OTHER_LDFLAGS": "-Xlinker -interposable $(inherited)",
                "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "\(additionalCondition) \(isDev ? "DEV" : "") DEBUG",
            ],
            release: [
                "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "\(additionalCondition) \(isDev ? "DEV" : "")",
            ]
        )
    )
}


let project = Project(
    name: "PopPopSeoul",
    options: .options(
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
            "CODE_SIGNING_REQUIRED": "NO"
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
            name: "PopPopSeoulKit",
            destinations: appDestinations,
            product: Environment.forPreview.getBoolean(default: false) ? .framework : .staticFramework,
            bundleId: "dev.suni.PopPopSeoulKit",
            deploymentTargets: appDeploymentTargets,
            infoPlist: .extendingDefault(with: [:]),
            sources: "Sources/AppKit/**",
            resources: .resources([
                "App/Resources/**",
                "Resources/AppKit/**"
            ]),
            dependencies: [
                .external(name: "ComposableArchitecture"),
                .external(name: "BottomSheet"),
                .external(name: "ComposableCoreLocation"),
                .external(name: "SwiftUIIntrospect"),
                .external(name: "Logging"),
                .external(name: "NMapsMap"),
                .target(name: "Common"),
            ]
        ),
        .target(
            name: "PopPopSeoulKitTests",
            destinations: appDestinations,
            product: .unitTests,
            bundleId: "dev.suni.PopPopSeoulkitTests",
            infoPlist: .default,
            sources: "Tests/AppKit/**",
            dependencies: [
                .target(name: "PopPopSeoulKit")
            ]
        ),
        .target(
            name: "Common",
            destinations: appDestinations,
            product: .staticFramework,
            bundleId: "dev.sunidev.poppopseoul.common",
            infoPlist: .default,
            sources: "Sources/Common/**",
            dependencies: [
                .external(name: "ComposableCoreLocation"),
                .external(name: "ComposableArchitecture"),
                .external(name: "Logging"),
            ]
        )
       ]
      )
)
