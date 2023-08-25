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
        ScrollView(showsIndicators: false) {
            VStack {
                Text("COZYINTHERE")
                    .font(.title3)
                    .foregroundColor(Color("solid.green"))
                    .padding(.bottom)

                VStack(alignment: .leading, spacing: 16) {
                    ForEach(news, id: \.id) { item in
                        dateCapsule(date: item.date)
                        card(data: item)
                    }
//                    dateCapsule()
//                    card(imageName: "umbagog")
//                    dateCapsule()
//                    card(imageName: "rainbowlake")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .task {
                self.news = await FireStoreService.shared.fetchNews("news")
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.9), Color.black.opacity(0.8)]), startPoint: .bottomLeading, endPoint: .topLeading)
        )
        .ignoresSafeArea(edges: .bottom)
        .overlay {
            if showsDetail {
                ScrollView(showsIndicators: false) {
                    VStack {
                        card(data: news.first ?? .init())
                        if showContent {
                            Text(news.first?.content ?? "")
                                .font(.footnote)
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

    @ViewBuilder
    private func dateCapsule(date: String) -> some View {
        Text(date)
            .font(.subheadline)
            .padding()
            .italic()
            .foregroundColor(Color("solid.gold"))
            .background(Color.white)
            .clipShape(Capsule())
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
                    Spacer()
                    Text("\(data.min) min read")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 16))
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
