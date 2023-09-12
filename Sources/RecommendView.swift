//
//  RecommendView.swift
//  cozyinthere
//
//  Created by Jimmy on 2023/08/29.
//  Copyright © 2023 com.cozyinthere. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import Kingfisher

struct Recommend: Reducer {
    struct State: Equatable {
        var recommend: [RecommendPayload] = []
    }

    enum Action: Equatable {
        case fetchRecommend
        case recommendResponse([RecommendPayload])
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchRecommend:
                return .run { send in
                    let data = await FireStoreService.shared.fetchRecommend()
                    await send(.recommendResponse(data))
                }
            case .recommendResponse(let data):
                state.recommend = data
                return .none
            }
        }
    }
}

struct RecommendView: View {
    let store: StoreOf<Recommend>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("직접 추천하는 여행지")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("개발자도 여행 중")
                        .font(.title3)
                        .bold()
                }
                .padding([.leading, .bottom])
                .frame(maxWidth: .infinity, alignment: .leading)

                if !viewStore.state.recommend.isEmpty {
                    CarouselView(trailingSpace: 40, items: viewStore.state.recommend) { slider in
                        ZStack(alignment: .bottomLeading) {
                            KFImage(URL(string: slider.image))
                                .resizable()
                                .aspectRatio(16 / 9, contentMode: .fill)
                                .cornerRadius(16)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(slider.title)
                                    .font(.callout)
                                Text(slider.subtitle)
                                    .font(.caption)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.7), .black.opacity(0.7)]),
                                               startPoint: .top, endPoint: .bottom)
                                    .cornerRadius(16)
                            )
                        }
                    }
                }
            }
            .task {
                viewStore.send(.fetchRecommend)
            }
        }
    }
}
