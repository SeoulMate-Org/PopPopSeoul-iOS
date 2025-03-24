import ProjectDescription

let project = Project(
    name: "SeoulMate",
    targets: [
        .target(
            name: "SeoulMate",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.SuniDev.SeoulMate",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["SeoulMate/Sources/**"],
            resources: ["SeoulMate/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "SeoulMateTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.SuniDev.SeoulMateTests",
            infoPlist: .default,
            sources: ["SeoulMate/Tests/**"],
            resources: [],
            dependencies: [.target(name: "SeoulMate")]
        ),
    ]
)
