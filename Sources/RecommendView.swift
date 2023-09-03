//
//  RecommendView.swift
//  cozyinthere
//
//  Created by Jimmy on 2023/08/29.
//  Copyright © 2023 com.cozyinthere. All rights reserved.
//

import Kingfisher
import SwiftUI

struct RecommendView: View {
    @State private var recommend: [RecommendPayload] = []
    @State private var index: Int = 0
    var body: some View {
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

            if !recommend.isEmpty {
                CarouselView(trailingSpace: 40, index: $index, items: recommend) { slider in
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
            self.recommend = await FireStoreService.shared.fetchRecommend()
        }
    }
}

// struct RecommendViewView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecommendView()
//    }
// }
