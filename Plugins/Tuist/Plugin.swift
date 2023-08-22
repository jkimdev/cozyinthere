import ProjectDescription

let project = Project(
    name: "cozyinthere",
    organizationName: "com.jimmy.cozyinthere",
    targets: [
        Target(
            name: "cozyinthere",
            platform: .iOS,
            product: .app,
            bundleId: "com.jimmy.cozyinthere",
            infoPlist: "Info.plist",
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                /* Target dependencies can be defined here */
                /* .framework(path: "framework") */
            ]
        ),
        Target(
            name: "cozyinthereTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jimmy.cozyinthereTests",
            infoPlist: "Info.plist",
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "cozyinthere")
            ]
        )
    ]
)
