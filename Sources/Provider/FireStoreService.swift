//
//  FireStoreService.swift
//  cozyinthere
//
//  Created by Jimmy on 2023/08/23.
//  Copyright © 2023 com.jimmy.cozyinthere. All rights reserved.
//

import Combine
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

@MainActor
final class FireStoreService {
    static let shared = FireStoreService()
    private let firestore: Firestore

    private init() {
        self.firestore = Firestore.firestore()
    }

    func fetchNews() async -> [NewsPayload] {
        let collection = firestore.collection("news")
        let data = try? await collection
            .getDocuments()
            .documents
            .map { NewsPayload($0) }
        return data ?? []
    }
    
    func fetchRecommend() async -> [RecommendPayload] {
        let collection = firestore.collection("recommend")
        let data = try? await collection
            .getDocuments()
            .documents
            .map { RecommendPayload($0) }
        return data ?? []
    }
}
