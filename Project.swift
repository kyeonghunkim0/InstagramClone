import ProjectDescription

let project = Project(
    name: "InstagramClone",
    targets: [
        .target(
            name: "InstagramClone",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.InstagramClone",
            deploymentTargets: DeploymentTargets.iOS("17.0"),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            buildableFolders: [
                "InstagramClone/Sources",
                "InstagramClone/Resources",
            ],
            dependencies: []
        ),
        .target(
            name: "InstagramCloneTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.InstagramCloneTests",
            infoPlist: .default,
            buildableFolders: [
                "InstagramClone/Tests"
            ],
            dependencies: [.target(name: "InstagramClone")]
        ),
    ]
)
