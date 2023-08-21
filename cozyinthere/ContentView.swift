//
//  ContentView.swift
//  cozyinthere
//
//  Created by Jimmy on 2023/08/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
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
