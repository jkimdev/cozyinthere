//
//  MainRepositoryImpl.swift
//  cozyinthere
//
//  Created by Jimmy on 2023/09/26.
//  Copyright © 2023 com.cozyinthere. All rights reserved.
//

import FirebaseFirestore
import Foundation

@MainActor
final class MainRepositoryImpl: MainRepository {
    private let firestore: Firestore

    init() {
        firestore = Firestore.firestore()
    }

    func fetchNews() async -> [QueryDocumentSnapshot] {
        let collection = firestore.collection("news")
        let data = try? await collection
            .getDocuments()
            .documents
        return data ?? []
    }

    func fetchRecommend() async -> [QueryDocumentSnapshot] {
        let collection = firestore.collection("recommend")
        let data = try? await collection
            .getDocuments()
            .documents
        return data ?? []
    }
}
