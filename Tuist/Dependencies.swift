//
//  Dependencies.swift
//  Config
//
//  Created by Jimmy on 2023/08/22.
//

import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    swiftPackageManager:
    .init([
        .firebase,
        .kingfisher,
        .swiftyJSON,
        .architecture
    ]),
    platforms: [.iOS]
)
