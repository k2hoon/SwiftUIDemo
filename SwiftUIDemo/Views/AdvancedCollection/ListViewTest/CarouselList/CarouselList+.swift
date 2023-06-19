//
//  CarouselList+.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/10.
//

import Foundation
import SwiftUI

extension CarouselList {
    struct Indicator: View {
        @Binding var currentIndex: Int
        var ragne: Range<Int>
        
        var body: some View {
            HStack(spacing: 10) {
                ForEach(self.ragne, id: \.self) { index in
                    Circle()
                        .fill(Color.black.opacity(currentIndex == index ? 1 : 0.1))
                        .frame(width: 8, height: 8)
                        .scaleEffect(currentIndex == index ? 1.5 : 1)
                        .animation(.spring(), value: currentIndex == index)
                }
            }
        }
    }
    
    struct TabButton: View {
        var type: CarouselType
        var animation: Namespace.ID
        @Binding var currentTab: CarouselType
        
        var body: some View {
            Button(action: {
                withAnimation(.spring()) {
                    currentTab = type
                }
            }) {
                Text(type.rawValue)
                    .foregroundColor(currentTab == type ? .white : .black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(
                        ZStack {
                            if currentTab == type {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.black)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    )
            }
        }
    }
    
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
    
}
