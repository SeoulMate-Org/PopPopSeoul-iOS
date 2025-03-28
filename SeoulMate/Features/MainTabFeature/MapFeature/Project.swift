import ProjectDescription

let project = Project(
  name: "MapFeature",
  targets: [
    .target(
      name: "MapFeature",
      destinations: .iOS,
      product: .framework,
      bundleId: "dev.sunidev.mapfeature",
      sources: ["Sources/**"],
      dependencies: []
    )
  ]
)
