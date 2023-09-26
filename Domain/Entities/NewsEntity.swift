//
//  NewsEntity.swift
//  cozyinthere
//
//  Created by Jimmy on 2023/09/26.
//  Copyright © 2023 com.cozyinthere. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct NewsEntity: Codable, Equatable {
    var id: String
    var title: String
    var content: String
    var image: String
    var author: String
    var authorImage: String
    var date: String
    var min: Int

    init(_ snapshot: QueryDocumentSnapshot) {
        self.id = snapshot.documentID
        self.title = snapshot["title"] as? String ?? ""
        self.content = snapshot["content"] as? String ?? ""
        self.image = snapshot["image"] as? String ?? ""
        self.author = snapshot["author"] as? String ?? ""
        self.authorImage = snapshot["authorImage"] as? String ?? ""
        self.date = snapshot["date"] as? String ?? ""
        self.min = snapshot["min"] as? Int ?? 0
    }
}
