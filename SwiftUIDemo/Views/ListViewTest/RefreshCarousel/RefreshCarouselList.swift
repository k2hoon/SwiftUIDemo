//
//  RefreshCarouselList.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/11.
//

import SwiftUI

struct RefreshCarouselList: View {
    struct Post: Identifiable {
        var id = UUID().uuidString
        var name: String
    }
    
    @State var currentIndex = 0
    @State var topOffset: CGFloat = 0
    @Namespace var animation
    
    var posts = [
        Post(name: "imagePost1"),
        Post(name: "imagePost2"),
        Post(name: "imagePost3"),
        Post(name: "imagePost4"),
        Post(name: "imagePost5"),
    ]
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            
            GeometryReader { proxy in
                let topEdge = proxy.safeAreaInsets.top
                
                VStack(spacing: 15) {
                    // top
                    TitleBack(title: "Carousel list", spacing: 12) {
                        // TODO: something
                    }
                    .frame(height: 70)
                    .padding()
                    .viewSize { size in
                        self.topOffset = size.height
                    }
                    
                    VCarouselList(
                        index: $currentIndex,
                        spacing: 12,
                        items: posts,
                        onRefresh: {
                            try? await Task.sleep(nanoseconds: 3_000_000_000)
                        },
                        content: { post in
                            PostCardView(post: post, topOffset: topOffset + topEdge + 15)
                        }
                    )
                    .padding(.horizontal, 20)
                }
            }
        }
    }
    
    // PostCardView
    struct PostCardView: View {
        var post: Post
        var topOffset: CGFloat
        
        var body: some View {
            // to get size of image
            GeometryReader { proxy in
                let size = proxy.size
                
                // scaling and opacity effect
                let minY = proxy.frame(in: .global).minY - topOffset
                let progress = -minY / size.height
                let scale = 1 - (progress / 3)
                let opacity = 1 - progress
                
                ZStack {
                    Image(post.name)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .cornerRadius(15)
                }
                .scaleEffect(minY < 0 ? scale : 1)
                .opacity(minY < 0 ? opacity : 1)
                // stopping view when y value goes < 0
                .offset(y: minY < 0 ? -minY : 0)
            }
        }
    }
    
    //
    struct VCarouselList<Content: View, T: Identifiable>: View {
        @Binding private var index: Int
        private var spacing: CGFloat
        private var trailingSpace: CGFloat
        private var list: [T]
        private var onRefresh: () async -> ()
        private var content: (T) -> Content
        private let THRESHOLD: CGFloat = 150
        private let indicatorHeight: CGFloat = 50
        
        init(index: Binding<Int>,
             spacing: CGFloat = 15,
             trailingSpace: CGFloat = 100,
             items: [T],
             onRefresh: @escaping () async -> (),
             @ViewBuilder content: @escaping (T) -> Content) {
            self._index = index
            self.list = items
            self.spacing = spacing
            self.trailingSpace = trailingSpace
            self.onRefresh = onRefresh
            self.content = content
        }
        
        @GestureState var offset: CGFloat = 0
        @State var currentIndex: Int = 0
        @State var offsetValue: CGFloat = 0
        @State var progress: CGFloat = 0
        @State var isEligible = false
        @State var isRefresh = false
        @State var lastIndex = 0
        
        var body: some View {
            GeometryReader { proxy in
                let height = proxy.size.height - (trailingSpace - spacing)
                let adjustMentHeight: CGFloat = 0
                
                ZStack(alignment: .top) {
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: isRefresh ? 0 : THRESHOLD * progress)
                        
                        ActivityIndicator(isAnimating: isRefresh, color: .white) {
                            $0.hidesWhenStopped = false
                        }
                    }
                    .opacity(progress)
                    
                    VStack(spacing: spacing) {
                        ForEach(list) { item in
                            self.content(item)
                                .frame(height: proxy.size.height - trailingSpace)
                        }
                    }
                    .onChange(of: self.isRefresh) { newValue in
                        if newValue {
                            Task {
                                await onRefresh()
                                withAnimation(.easeInOut) {
                                    self.progress = 0
                                    self.isEligible = false
                                    self.isRefresh = false
                                }
                            }
                        }
                    }
                    .alignmentGuide(.top) { _ in
                        isEligible ? -indicatorHeight : 0
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
                                
                                
                                
                                self.offsetValue = offsetY
                                
                                if !isRefresh && index == 0 {
                                    if offsetY > THRESHOLD {
                                        self.isEligible = true
                                    } else {
                                        self.isEligible = false
                                        self.progress = 0
                                    }
                                }
                                
                                if isEligible && !isRefresh {
                                    self.isRefresh = true
                                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                }
                                
                                currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                                index = currentIndex
                            })
                            .onChanged({ value in
                                let offsetY = value.translation.height
                                let progress = -offsetY / height
                                let roundIndex = progress.rounded()
                                
                                if index == 0 {
                                    let drag = offsetY / THRESHOLD
                                    self.progress = (drag < 0 ? 0 : drag)
                                    self.progress = (drag > 1 ? 1 : drag)
                                }
                                
                                lastIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                            })
                    )
                    
                    
                }
                .animation(.easeInOut, value: offset == 0)
            }
        }
    }
    
    struct ActivityIndicator: UIViewRepresentable {
        typealias UIView = UIActivityIndicatorView
        
        var isAnimating: Bool = true
        var color: Color
        var configuration = { (indicator: UIView) in }
        
        init(isAnimating: Bool, color: Color, configuration: ((UIView) -> Void)? = nil) {
            self.isAnimating = isAnimating
            self.color = color
            if let configuration = configuration {
                self.configuration = configuration
            }
        }
        
        func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView {
            let view = UIView()
            view.color = self.color.toUIColor()
            return view
        }
        
        func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
            isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
            configuration(uiView)
        }
    }   
}

struct RefreshCarouselList_Previews: PreviewProvider {
    static var previews: some View {
        RefreshCarouselList()
    }
}
