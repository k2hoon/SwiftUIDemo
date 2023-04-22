//
//  CarouselList.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/10.
//

import SwiftUI

struct CarouselList: View {
    enum CarouselType: String {
        case horizontal = "Horizontal"
        case vertical = "Vertical"
    }
    
    @State var currentIndex = 0
    @State var currentType: CarouselType = .vertical
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
        VStack(spacing: 15) {
            // top
            VStack {
                TitleBack(title: "Carousel list", spacing: 12) {
                    // TODO: something
                }
                .frame(height: 70)
                .padding()
                
                // segment control
                HStack(spacing: 0) {
                    TabButton(type: .horizontal, animation: animation, currentTab: $currentType)
                    
                    TabButton(type: .vertical, animation: animation, currentTab: $currentType)
                }
                .background(Color.black.opacity(0.4), in: RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            }
            
            switch currentType {
            case .horizontal:
                HCarouselList(index: $currentIndex, spacing: 30, items: posts) { post in
                    GeometryReader { proxy in
                        let size = proxy.size
                        
                        Image(post.name)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .cornerRadius(12)
                    }
                }
                .padding(.vertical, 40)
                
                // indicator
                Indicator(currentIndex: $currentIndex, ragne: self.posts.indices)
                    .padding(.bottom, 40)
            case .vertical:
                // indicator
                Indicator(currentIndex: $currentIndex, ragne: self.posts.indices)
                    .frame(height: 40)
                
                GeometryReader { proxy in
                    let topEdge = proxy.safeAreaInsets.top
                    
                    VCarouselList(index: $currentIndex, spacing: 30, items: posts) { post in
                        PostCardView(post: post, topOffset: 70 + 120 + 60 + topEdge)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, topEdge)
                    .ignoresSafeArea(.all, edges: .top)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct CarouselList_Previews: PreviewProvider {
    static var previews: some View {
        CarouselList()
    }
}


