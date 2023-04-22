//
//  CarouselList+Horizontal.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/10.
//

import SwiftUI

extension CarouselList {
    struct HCarouselList<Content: View, T: Identifiable>: View {
        @Binding var index: Int
        var spacing: CGFloat
        var trailingSpace: CGFloat
        var list: [T]
        var content: (T) -> Content
        
        @GestureState private var offset: CGFloat = 0
        @State private var currentIndex: Int = 0
        
        init(index: Binding<Int>,
             spacing: CGFloat = 15,
             trailingSpace: CGFloat = 100,
             items: [T],
             @ViewBuilder content: @escaping (T) -> Content) {
            self._index = index
            self.list = items
            self.spacing = spacing
            self.trailingSpace = trailingSpace
            self.content = content
        }
        
        var body: some View {
            GeometryReader { proxy in
                let width = proxy.size.width - (trailingSpace - spacing)
                let adjustMentWidth = (trailingSpace / 2) - spacing
                
                HStack(spacing: spacing) {
                    ForEach(list) { item in
                        self.content(item)
                            .frame(width: proxy.size.width - trailingSpace)
                    }
                }
                .padding(.horizontal, spacing)
                .offset(x: (CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adjustMentWidth : 0) + offset)
                .gesture(
                    DragGesture()
                        .updating($offset, body: { value, out, _ in
                            out = value.translation.width
                        })
                        .onEnded({ value in
                            let offsetX = value.translation.width
                            let progress = -offsetX / width
                            let roundIndex = progress.rounded()
                            
                            currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                            
                            currentIndex = index
                        })
                        .onChanged({ value in
                            let offsetX = value.translation.width
                            let progress = -offsetX / width
                            let roundIndex = progress.rounded()
                                                    
                            index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        })
                )
            }
            .animation(.easeInOut, value: offset == 0)
        }
    }
}

struct CarouselList_Horizontal_Previews: PreviewProvider {
    static var previews: some View {
        CarouselList()
    }
}
