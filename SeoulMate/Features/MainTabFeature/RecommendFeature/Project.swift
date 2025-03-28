import ProjectDescription

let project = Project(
  name: "RecommendFeature",
  targets: [
    .target(
      name: "RecommendFeature",
      destinations: .iOS,
      product: .framework,
      bundleId: "dev.sunidev.recommendfeature",
      sources: ["Sources/**"],
      dependencies: []
    )
  ]
)
