//
//  NewsPayload.swift
//  cozyinthere
//
//  Created by Jimmy on 2023/08/23.
//  Copyright © 2023 com.jimmy.cozyinthere. All rights reserved.
//

import Foundation
import SwiftyJSON
import FirebaseFirestore

struct NewsPayload: Codable, Equatable {
    var id: String
    var title: String
    var content: String
    var image: String
    var author: String
    var authorImage: String
    var date: String
    var min: Int
    
    init(id: String = "", title: String = "", content: String = "", image: String = "", author: String = "", authorImage: String = "", date: String = "", min: Int = 0) {
        self.id = id
        self.title = title
        self.content = content
        self.image = image
        self.author = author
        self.authorImage = authorImage
        self.date = date
        self.min = min
    }
    
    init(_ entity: NewsEntity) {
        self.id = entity.id
        self.title = entity.title
        self.content = entity.content
        self.image = entity.image
        self.author = entity.author
        self.authorImage = entity.authorImage
        self.date = entity.date
        self.min = entity.min
    }
}
