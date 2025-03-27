import ProjectDescription

let project = Project(
  name: "AppFeature",
  targets: [
    .target(
      name: "AppFeature",
      destinations: .iOS,
      product: .framework,
      bundleId: "dev.sunidev.appfeature",
      sources: ["Sources/**"],
      dependencies: []
    )
  ]
)

