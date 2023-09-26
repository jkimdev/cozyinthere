//
//  Dependencies.swift
//  cozyinthere
//
//  Created by Jimmy on 2023/09/26.
//  Copyright © 2023 com.cozyinthere. All rights reserved.
//

import Foundation
import ComposableArchitecture

extension MainUseCaseImpl: DependencyKey {
    static var liveValue: MainUseCaseImpl {
        MainUseCaseImpl(repository: MainRepositoryImpl())
    }
}

extension DependencyValues {
    var mainUseCase: MainUseCaseImpl {
        get { self[MainUseCaseImpl.self] }
        set { self[MainUseCaseImpl.self] = newValue }
    }
}
