//
//  ContentView.swift
//  cozyinthere
//
//  Created by Jimmy on 2023/08/19.
//

import SwiftUI

struct ContentView: View {
    @Namespace var animation
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
                    dateCapsule(date: "Aug 19")
                    card(imageName: "stmarylake")
//                    dateCapsule()
//                    card(imageName: "umbagog")
//                    dateCapsule()
//                    card(imageName: "rainbowlake")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.9), Color.black.opacity(0.8)]), startPoint: .bottomLeading, endPoint: .topLeading)
        )
        .ignoresSafeArea(edges: .bottom)

        .overlay {
            if showsDetail {
                VStack {
                    card(imageName: "stmarylake")
                    Spacer()
                }
                .ignoresSafeArea()
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
    private func card(imageName: String) -> some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .aspectRatio(16 / 9, contentMode: .fit)
            VStack(alignment: .leading) {
                HStack {
                    Image("writer.image")
                        .clipShape(Circle())
                    Text("Chaeho Lim")
                        .font(.system(size: 12))
                }
                HStack(alignment: .lastTextBaseline) {
                    Text("St. Mary Lake")
                        .font(.title3)
                        .bold()
                    Spacer()
                    Text("5 min read")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .onTapGesture {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                showsDetail = true
            }
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.2)) {
                showContent = true
            }
        }
        .matchedGeometryEffect(id: "card", in: animation)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
