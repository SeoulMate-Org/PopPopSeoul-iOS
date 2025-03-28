import ProjectDescription

let project = Project(
  name: "IntroFeature",
  targets: [
    .target(
      name: "IntroFeature",
      destinations: .iOS,
      product: .framework,
      bundleId: "dev.sunidev.introfeature",
      sources: ["Sources/**"],
      dependencies: []
    )
  ]
)
