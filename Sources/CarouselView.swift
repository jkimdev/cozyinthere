//
//  CarouselView.swift
//  cozyinthere
//
//  Created by Jimmy on 2023/09/01.
//  Copyright © 2023 com.cozyinthere. All rights reserved.
//

import SwiftUI

struct CarouselView<Content: View, T: Identifiable>: View {
    var content: (T) -> Content
    var list: [T]
    
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @State var index: Int = 0
    
    init(spacing: CGFloat = 15, trailingSpace: CGFloat = 100, items: [T], @ViewBuilder content: @escaping (T) -> Content) {
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self.content = content
    }
    
    @GestureState var offset: CGFloat = 0
    @State var currentSlider: Int = 0
    
    var body: some View {
        GeometryReader { proxy in
            
            let width = proxy.size.width - (trailingSpace - spacing)
            let adjustmentWidth = (trailingSpace / 2) - spacing
            
            HStack(spacing: spacing) {
                ForEach(list) { item in
                    content(item)
                        .frame(width: proxy.size.width - trailingSpace)
                }
            }
            .padding(.horizontal, spacing)
            .offset(x: (CGFloat(currentSlider) * -width) + (currentSlider != 0 ? adjustmentWidth : 0) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded { value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                    
                        currentSlider = max(min(currentSlider + Int(roundIndex), list.count - 1), 0)
                    
                        currentSlider = index
                    }
                    .onChanged { value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                    
                        index = max(min(currentSlider + Int(roundIndex), list.count - 1), 0)
                    }
            )
        }
        .animation(.easeInOut, value: offset == 0)
    }
}
