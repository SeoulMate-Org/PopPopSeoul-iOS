import ProjectDescription

let workspace = Workspace(
  name: "SeoulMate",
  projects: ["."],
  generationOptions: .options(
    lastXcodeUpgradeCheck: Version(15, 4, 0)
  )
)
