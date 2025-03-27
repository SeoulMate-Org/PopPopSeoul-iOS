import ProjectDescription

let project = Project(
  name: "ApiClient",
  targets: [
    .target(
      name: "ApiClient",
      destinations: .iOS,
      product: .framework,
      bundleId: "dev.sunidev.apiclient",
      sources: ["Sources/**"],
      dependencies: []
    )
  ]
)
