//
//  ContentView.swift
//  cozyinthere
//
//  Created by Jimmy on 2023/09/08.
//  Copyright © 2023 com.cozyinthere. All rights reserved.
//

import ComposableArchitecture
import Kingfisher
import SwiftUI

struct Main: Reducer {
    @Dependency(\.mainUseCase) var mainUseCase

    struct State: Equatable {
        var news: [NewsPayload] = []
        var selectedNews: NewsPayload = .init()
        var isPressed: Bool = false
        var showsDetail: Bool = false
        var showContent: Bool = false
        var recommend: Recommend.State = .init()
    }

    enum Action: Equatable {
        case fetchNews
        case fetchNewsResponse(TaskResult<[NewsEntity]>)
        case onTapNews(NewsPayload)
        case onContentAppear
        case onTapCloseButton
        case recommend(Recommend.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.recommend, action: /Action.recommend) {
            Recommend()
        }
        Reduce { state, action in
            switch action {
            case .fetchNews:
                return .run { send in
                    let result = await TaskResult {
                        let data = await mainUseCase.fetchNews()
                        return data
                    }
                    await send(.fetchNewsResponse(result))
                }

            case .fetchNewsResponse(.success(let data)):
                state.news = data.map { NewsPayload($0) }
                return .none

            case .onTapNews(let news):
                state.selectedNews = news
                state.showsDetail = true
                return .none

            case .onContentAppear:
                state.showContent = true
                return .none

            case .onTapCloseButton:
                state.showsDetail = false
                state.showContent = false
                return .none

            default:
                return .none
            }
        }
    }
}

struct MainView: View {
    let store: StoreOf<Main>
    @Namespace var animation

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(viewStore.news, id: \.id) { item in
                            header(date: item.date)
                            card(data: item)
                            Divider()
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)

                    RecommendView(
                        store: self.store.scope(
                            state: \.recommend,
                            action: Main.Action.recommend))
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [Color("backgroundColor"),
                                     Color("backgroundColor").opacity(0.5),
                                     Color("backgroundColor").opacity(0.1)]),
                        startPoint: .bottomTrailing,
                        endPoint: .topLeading)
                )
                .task {
                    viewStore.send(.fetchNews)
                }
                .ignoresSafeArea(edges: .bottom)
            }
            .overlay {
                if viewStore.showsDetail {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            card(data: viewStore.selectedNews)
                            if viewStore.showContent {
                                Text(viewStore.selectedNews.content.replacingOccurrences(of: "\\n", with: "\n"))
                                    .font(.system(size: 16))
                                    .lineSpacing(4)
                                    .padding()
                            }
                        }
                    }
                    .ignoresSafeArea(edges: .top)
                    .background()
                    .safeAreaInset(edge: .top, content: {
                        Image(systemName: "xmark.circle")
                            .imageScale(.large)
                            .onTapGesture {
                                viewStore.send(.onTapCloseButton, animation: .interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6))
                            }
                            .padding(.trailing)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    })
                }
            }
        }
    }

    @ViewBuilder
    private func header(date: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("8월 27일 일요일")
                .font(.caption2)
                .foregroundColor(.gray)
            Text("Latest")
                .font(.largeTitle)
                .bold()
        }
    }

    @ViewBuilder
    func card(data: NewsPayload) -> some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: data.image))
                .resizable()
                .aspectRatio(16 / 9, contentMode: .fit)
            VStack(alignment: .leading) {
                HStack {
                    KFImage(URL(string: data.authorImage))
                        .resizable()
                        .frame(width: 24, height: 24)
                        .clipShape(Circle())
                    Text(data.author)
                        .font(.system(size: 12))
                }
                HStack(alignment: .lastTextBaseline) {
                    Text(data.title)
                        .font(.title3)
                        .bold()
                        .lineLimit(2)
                    Spacer()
                    Text("\(data.min) min read")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
        }
        .onTapGesture {
            store.send(.onTapNews(data), animation: .interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6))
            store.send(.onContentAppear, animation: .interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.2))
        }
        .matchedGeometryEffect(id: "card", in: animation)
    }
}
