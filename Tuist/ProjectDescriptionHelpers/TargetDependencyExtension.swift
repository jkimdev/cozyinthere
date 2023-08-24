//
//  TargetDependencyExtension.swift
//  ProjectDescriptionHelpers
//
//  Created by Jimmy on 2023/08/22.
//

import ProjectDescription

public extension TargetDependency {
    static let firebaseAnalytics: TargetDependency = .external(name: "FirebaseAnalytics")
    static let firebaseMessaging: TargetDependency = .external(name: "FirebaseMessaging")
    static let firebaseCrashlytics: TargetDependency = .external(name: "FirebaseCrashlytics")
    static let firebaseFireStore: TargetDependency = .external(name: "FirebaseFirestoreSwift")
    static let swiftyJSON: TargetDependency = .external(name: "SwiftyJSON")
    static let kingfisher: TargetDependency = .external(name: "Kingfisher")
}

public extension Package {
    static let firebase: Package = .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .branch("master"))
    static let swiftyJSON: Package = .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", .branch("master"))
    static let kingfisher: Package = .package(url: "https://github.com/onevcat/Kingfisher.git", .branch("master"))
}

// MARK: SourceFile

public extension SourceFilesList {
    static let sources: SourceFilesList = "Sources/**"
    static let tests: SourceFilesList = "Tests/**"
}

// MARK: Resource

public enum ResourceType: String {
    case xibs = "Sources/**/*.xib"
    case storyboards = "Resources/**/*.storyboard"
    case assets = "Resources/**"
}

// MARK: Extension

public extension Array where Element == FileElement {
    static func resources(with resources: [ResourceType]) -> [FileElement] {
        resources.map { FileElement(stringLiteral: $0.rawValue) }
    }
}
