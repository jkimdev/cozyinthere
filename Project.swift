import ProjectDescription
import ProjectDescriptionHelpers
//import MyPlugin

/*
                +-------------+
                |             |
                |     App     | Contains Tuist App target and Tuist unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

// Local plugin loaded
//let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
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
                .firebaseAnalytics,
                .firebaseMessaging,
                .firebaseCrashlytics,
                .firebaseFireStore,
                .kingfisher,
                .swiftyJSON
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
