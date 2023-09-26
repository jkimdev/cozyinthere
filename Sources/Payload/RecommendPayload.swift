//
//  RecommendPayload.swift
//  cozyinthere
//
//  Created by Jimmy on 2023/08/30.
//  Copyright © 2023 com.cozyinthere. All rights reserved.
//

import FirebaseFirestore
import Foundation

struct RecommendPayload: Equatable, Identifiable {
    var id: String
    var title: String
    var subtitle: String
    var image: String
    var contents: String
    
    init(id: String = "", title: String = "", subtitle: String = "", image: String = "", contents: String = "") {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.contents = contents
    }

    init(_ entity: RecommendEntity) {
        self.id = entity.id
        self.title = entity.title
        self.subtitle = entity.subtitle
        self.image = entity.image
        self.contents = entity.contents
    }
}
