//
//  ContentView.swift
//  cozyinthere
//
//  Created by Jimmy on 2023/08/19.
//

import Kingfisher
import SwiftUI

struct ContentView: View {
    @Namespace var animation
    @State private var news: [NewsPayload] = []
    @State private var selectedNews: NewsPayload = .init()
    @State private var isPressed: Bool = false
    @State private var showsDetail: Bool = false
    @State private var showContent: Bool = false
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(news, id: \.id) { item in
                        header(date: item.date)
                        card(data: item)
                        Divider()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)

                RecommendView()
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color("backgroundColor"), Color("backgroundColor").opacity(0.5), Color("backgroundColor").opacity(0.1)]), startPoint: .bottomTrailing, endPoint: .topLeading)
            )
            .task {
                self.news = await FireStoreService.shared.fetchNews()
            }
            .ignoresSafeArea(edges: .bottom)
            .overlay {
                if showsDetail {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            card(data: news.first ?? .init())
                            if showContent {
                                Text(news.first?.content ?? "")
                                    .font(.system(size: 16))
                                    .lineSpacing(4)
                                    .padding()
                            }
                        }
                    }
                    .ignoresSafeArea(edges: .top)
                    .background()
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                            showsDetail = false
                            showContent = false
                        }
                    }
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
    private func card(data: NewsPayload) -> some View {
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
            selectedNews = data
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                showsDetail = true
            }
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.2)) {
                showContent = true
            }
        }
        .matchedGeometryEffect(id: data.id, in: animation)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
