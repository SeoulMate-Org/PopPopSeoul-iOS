import ProjectDescription

let project = Project(
  name: "FavoritesFeature",
  targets: [
    .target(
      name: "FavoritesFeature",
      destinations: .iOS,
      product: .framework,
      bundleId: "dev.sunidev.favoritesfeature",
      sources: ["Sources/**"],
      dependencies: []
    )
  ]
)
