//
//  RecommendEntity.swift
//  cozyinthere
//
//  Created by Jimmy on 2023/09/26.
//  Copyright © 2023 com.cozyinthere. All rights reserved.
//

import FirebaseFirestore
import Foundation

struct RecommendEntity: Equatable, Identifiable {
    var id: String
    var title: String
    var subtitle: String
    var image: String
    var contents: String

    init(_ snapshot: QueryDocumentSnapshot) {
        self.id = snapshot.documentID
        self.title = snapshot["title"] as? String ?? ""
        self.subtitle = snapshot["subtitle"] as? String ?? ""
        self.image = snapshot["image"] as? String ?? ""
        self.contents = snapshot["contents"] as? String ?? ""
    }
}
