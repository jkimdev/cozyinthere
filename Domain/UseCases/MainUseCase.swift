//
//  MainUseCase.swift
//  cozyinthere
//
//  Created by Jimmy on 2023/09/26.
//  Copyright © 2023 com.cozyinthere. All rights reserved.
//

import Foundation

protocol MainUseCase {
    func fetchNews() async -> [NewsEntity]
    func fetchRecommend() async -> [RecommendEntity]
}

@MainActor
final class MainUseCaseImpl: MainUseCase {
    private let repository: MainRepository

    init(repository: MainRepository) {
        self.repository = repository
    }

    func fetchNews() async -> [NewsEntity] {
        return await repository.fetchNews()
            .map { NewsEntity($0) }
    }

    func fetchRecommend() async -> [RecommendEntity] {
        return await repository.fetchRecommend()
            .map { RecommendEntity($0) }
    }
}
