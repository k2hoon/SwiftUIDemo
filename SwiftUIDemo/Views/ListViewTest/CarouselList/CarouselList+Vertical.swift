//
//  CarouselList+Vertical
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/10.
//

import SwiftUI

extension CarouselList {
    struct VCarouselList<Content: View, T: Identifiable>: View {
        @Binding private var index: Int
        private var spacing: CGFloat
        private var trailingSpace: CGFloat
        private var list: [T]
        private var content: (T) -> Content
        
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
        
        // offset
        @GestureState var offset: CGFloat = 0
        @State var currentIndex: Int = 0
        
        var body: some View {
            GeometryReader { proxy in
                let height = proxy.size.height - (trailingSpace - spacing)
                let adjustMentHeight: CGFloat = 0
//                let adjustMentHeight: CGFloat = (trailingSpace / 2) - spacing
                
                VStack(spacing: spacing) {
                    ForEach(list) { item in
                        self.content(item)
                            .frame(height: proxy.size.height - trailingSpace)
                    }
                }
                .offset(y: (CGFloat(currentIndex) * -height) + (currentIndex != 0 ? adjustMentHeight : 0) + offset)
                .gesture(
                    DragGesture()
                        .updating($offset, body: { value, out, _ in
                            out = value.translation.height
                        })
                        .onEnded({ value in
                            let offsetY = value.translation.height
                            let progress = -offsetY / height
                            let roundIndex = progress.rounded()
                            
                            currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                            
                            currentIndex = index
                        })
                        .onChanged({ value in
                            let offsetY = value.translation.height
                            let progress = -offsetY / height
                            let roundIndex = progress.rounded()
                            
                            index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        })
                )
            }
            .animation(.easeInOut, value: offset == 0)
        }
    }
    
}

struct CarouselList_Vertical_Previews: PreviewProvider {
    static var previews: some View {
        CarouselList(currentType: .vertical)
    }
}

