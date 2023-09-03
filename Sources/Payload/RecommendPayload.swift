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

    init(_ snapshot: QueryDocumentSnapshot) {
        self.id = snapshot.documentID
        self.title = snapshot["title"] as? String ?? ""
        self.subtitle = snapshot["subtitle"] as? String ?? ""
        self.image = snapshot["image"] as? String ?? ""
        self.contents = snapshot["contents"] as? String ?? ""
    }
}
