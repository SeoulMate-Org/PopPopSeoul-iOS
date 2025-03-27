import ProjectDescription

let project = Project(
    name: "App",
    targets: [
        .target(
            name: "App",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.sunidev.seoulmate",
            infoPlist: .file(path: "../Resources/Info.plist"), // Info.plist 생성 필요
            sources: ["Sources/**"],
            resources: ["../Resources/**"],
            dependencies: [
                .project(target: "AppFeature", path: "../Features/AppFeature")
            ]
        )
    ]
)
