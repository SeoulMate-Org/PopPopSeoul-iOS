import ProjectDescription

let project = Project(
  name: "HomeFeature",
  targets: [
    .target(
      name: "HomeFeature",
      destinations: .iOS,
      product: .framework,
      bundleId: "dev.sunidev.homefeature",
      sources: ["Sources/**"],
      dependencies: []
    )
  ]
)
