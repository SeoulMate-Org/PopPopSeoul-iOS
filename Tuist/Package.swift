// swift-tools-version: 6.0
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings()
#endif

let package = Package(
    name: "SeoulMateDependencies",
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            .upToNextMajor(from: "1.0.0")
        ),
        .package(
            url: "https://github.com/apple/swift-log.git",
            .upToNextMajor(from: "1.0.0")
        ),
        .package(
            url: "https://github.com/mltbnz/composable-core-location.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/lucaszischka/BottomSheet.git",
            .upToNextMajor(from: "3.1.0")
        ),
        .package(
            url: "https://github.com/siteline/SwiftUI-Introspect.git",
            .upToNextMajor(from: "1.0.0")
        ),
        .package(
            url: "https://github.com/navermaps/SPM-NMapsMap.git",
            .upToNextMajor(from: "3.16.1")
        ),
        .package(
            url: "https://github.com/google/GoogleSignIn-iOS",
            .upToNextMajor(from: "8.0.0")
        ),
        .package(
            url: "https://github.com/facebook/facebook-ios-sdk",
            .upToNextMajor(from: "18.0.0")
        )
    ]
)
