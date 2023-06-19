//
//  CustomCarousel.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/07.
//

import SwiftUI

struct CustomCarousel: View {
    enum CustomTabTag: String {
        case carousel = "Custom carousel"
        case search = "Search"
        case following = "Following"
        case downloads = "Downloads"
    }
    
    @State private var cutomTag: CustomTabTag = .carousel
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $cutomTag) {
            // to get safe area
            GeometryReader { proxy in
                let topEdge = proxy.safeAreaInsets.top
                
                VerticalCarouselView(topEdge: topEdge)
                    .padding(.top, topEdge)
                    .ignoresSafeArea(.all, edges: .top)
            }
            .tag(CustomTabTag.carousel)
            
            Text("Search")
                .tag(CustomTabTag.search)
            
            Text("Following")
                .tag(CustomTabTag.following)
            
            Text("Downloads")
                .tag(CustomTabTag.downloads)
        }
        .overlay(alignment: .bottom) {
            CustomTabBar(currentTab: $cutomTag)
        }
    }
}

struct CustomCarousel_Previews: PreviewProvider {
    static var previews: some View {
        CustomCarousel()
    }
}

// MARK: - Custom tab view
struct CustomTabBar: View {
    @Binding var currentTab: CustomCarousel.CustomTabTag
    
    var body: some View {
        HStack(spacing: 0) {
            CustomTabBarButton(currentTab: $currentTab, tab: .carousel , image: "rectangle.portrait")
            
            CustomTabBarButton(currentTab: $currentTab, tab: .search, image: "magnifyingglass")
            
            CustomTabBarButton(currentTab: $currentTab, tab: .following, image: "bookmark")
            
            CustomTabBarButton(currentTab: $currentTab, tab: .downloads, image: "square.and.arrow.down")
        }
        .frame(height: 60)
        .background(.ultraThinMaterial)
    }
}

struct CustomTabBarButton: View {
    @Binding var currentTab: CustomCarousel.CustomTabTag
    var tab: CustomCarousel.CustomTabTag
    var image: String
    
    var body: some View {
        Button(action: {
            withAnimation {
                currentTab = tab
            }
        }) {
            VStack {
                Image(systemName: image)
                    .font(.title2)
                
                Text(tab.rawValue)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .foregroundColor(tab == currentTab ? .primary : .gray)
            .frame(maxWidth: .infinity)
        }
    }
}
