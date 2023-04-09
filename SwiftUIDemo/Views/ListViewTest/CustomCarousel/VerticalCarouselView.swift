//
//  VerticalCarouselView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/07.
//

import SwiftUI

struct VerticalCarouselView: View {
    var topEdge: CGFloat
    var postCards = [
        PostCard(index: 0, name: "ImageThunderStorm", artwork: "post1"),
        PostCard(index: 1, name: "night-city", artwork: "post2"),
        PostCard(index: 2, name: "ImageThunderStorm", artwork: "post3"),
        PostCard(index: 3, name: "night-city", artwork: "post4"),
        PostCard(index: 4, name: "ImageThunderStorm", artwork: "post5"),
        PostCard(index: 5, name: "night-city", artwork: "post6"),
        PostCard(index: 6, name: "ImageThunderStorm", artwork: "post7"),
        PostCard(index: 7, name: "night-city", artwork: "post8"),
    ]
    
    var body: some View {
        VStack(spacing: 15) {
            TitlePerson(title: "Custom carousel")
                .padding(.horizontal)
                .frame(height: 70)
                .border(.red)
            
            GeometryReader { proxy in
                let size = proxy.size
                
                VerticalCarouselList {
                    VStack(spacing: 0) {
                        ForEach(self.postCards) { post in
                            // 70 = title view
                            // 15 = spacing
                            // remaining is safearea top
                            CardView(post: post, topOffset: 70 + 15 + topEdge)
                                .frame(height: size.height)
                                .border(.green)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                }
            }
        }
    }
}

struct VerticalCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCarousel()
    }
}

// MARK: - VerticalCarouselView model
extension VerticalCarouselView {
    struct PostCard: Identifiable {
        var id = UUID().uuidString
        var index: Int
        var name: String
        var artwork: String
    }
}

// MARK: - VerticalCarouselView card view
extension VerticalCarouselView {
    struct CardView: View {
        var post: PostCard
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
                        .frame(width: size.width, height: size.height - 80)
                        .cornerRadius(15)
                }
                .border(.red)
                .scaleEffect(minY < 0 ? scale : 1)
                .opacity(minY < 0 ? opacity : 1)
                // stopping view when y value goes < 0
                .offset(y: minY < 0 ? -minY : 0)
            }
        }
    }
}
