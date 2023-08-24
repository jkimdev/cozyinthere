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

struct NewsPayload: Codable {
    var title: String
    var content: String
    var image: String
    var author: String
    var date: String
    var min: Int
    
    init(title: String, content: String, image: String, author: String, date: String, min: Int) {
        self.title = title
        self.content = content
        self.image = image
        self.author = author
        self.date = date
        self.min = min
    }
    
    init(_ snapshot: QueryDocumentSnapshot) {
        self.title = snapshot["title"] as? String ?? ""
        self.content = snapshot["content"] as? String ?? ""
        self.image = snapshot["image"] as? String ?? ""
        self.author = snapshot["author"] as? String ?? ""
        self.date = snapshot["date"] as? String ?? ""
        self.min = snapshot["title"] as? Int ?? 0
    }
}
