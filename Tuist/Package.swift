// swift-tools-version: 6.0
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
    productTypes: [
//        "FBLPromises": .framework,
//        "GTMSessionFetcher": .framework,
//        "GoogleUtilities": .framework,
//        "AppCheckCore": .framework,
//        "GoogleSignIn": .framework,
//        "GTMAppAuth": .framework,
        "AppAuth": .framework,
    ]
)
#endif

let package = Package(
    name: "SeoulMateDependencies",
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            branch: "main"
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
            url: "https://github.com/navermaps/SPM-NMapsMap.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/google/GoogleSignIn-iOS",
            branch: "main"
        ),
        .package(
            url: "https://github.com/facebook/facebook-ios-sdk",
            branch: "main"
        ),
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk",
            branch: "main"
        )
    ]
)
