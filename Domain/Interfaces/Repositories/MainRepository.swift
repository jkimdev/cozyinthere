//
//  MainRepository.swift
//  cozyinthere
//
//  Created by Jimmy on 2023/09/26.
//  Copyright © 2023 com.cozyinthere. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol MainRepository {
    func fetchNews() async -> [QueryDocumentSnapshot]
    func fetchRecommend() async -> [QueryDocumentSnapshot]
}
