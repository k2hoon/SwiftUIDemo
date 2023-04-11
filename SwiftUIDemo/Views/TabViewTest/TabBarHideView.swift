//
//  TabBarHideView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/12.
//

import SwiftUI

struct TabBarHideHome: View {
    var body: some View {
        GeometryReader { proxy in
            let bottomEdge = proxy.safeAreaInsets.bottom
            TabBarHideView(bottomEdge: bottomEdge == 0 ? 15 : bottomEdge)
                .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

struct TabBarHideView: View {
    enum TabItem: String {
        case mail = "Mail"
        case meet = "Meet"
    }
    
    @State var currentTab: TabItem = .mail
    @State var hideBar = false
    var bottomEdge: CGFloat
    
    var tabItems: [(name: TabItem, systemName: String)] = [
        (.mail, "envelope.fill"),
        (.meet, "video")
    ]
    
    init(bottomEdge: CGFloat) {
        UITabBar.appearance().isHidden = true
        self.bottomEdge = bottomEdge
    }
    
    var body: some View {
        TabView(selection: $currentTab) {
            MailView(hideTab: $hideBar, bottomEdge: bottomEdge)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.primary.opacity(0.05))
                .tag(tabItems[0].name)
            
            Text(tabItems[1].name.rawValue)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.primary.opacity(0.05))
                .tag(tabItems[1].name)
        }
        .overlay(alignment: .bottom) {
            VStack {
                Button(action: {
                    withAnimation { hideBar.toggle() }
                }) {
                    HStack(spacing: hideBar ? 0 : 12) {
                        Image(systemName: "pencil")
                            .font(.title)
                        Text("Compose")
                            .fontWeight(.semibold)
                            .frame(width: hideBar ? 0 : nil, height: hideBar ? 0 : nil)
                    }
                    .foregroundColor(.pink)
                    .padding(.vertical, hideBar ? 15 : 12)
                    .padding(.horizontal)
                    .background(.white, in: Capsule())
                    .shadow(color: .primary.opacity(0.06), radius: 5, x: 5, y: 10)
                }
                .padding(.trailing)
                .offset(y: -15)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .opacity(currentTab == .mail ? 1 : 0)
                .animation(.none, value: currentTab)
                
                CustomTabBar(currentTab: $currentTab, tabItems: tabItems, bottomEdge: bottomEdge)
            }
            // hide tab bar when scrolled
            .offset(y: hideBar ? (15 + 35 + bottomEdge) : 0)
        }
    }
}

struct TabBarHideView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarHideHome()
    }
}

struct TabBarButton: View {
    @Environment(\.colorScheme) var scheme
    @Binding var currentTab: TabBarHideView.TabItem
    
    var tabItem: (name: TabBarHideView.TabItem, systemName: String)
    var badge: Int = 0
    
    var body: some View {
        Button(action: {
            withAnimation {
                currentTab = tabItem.name
            }
        }) {
            Image(systemName: tabItem.systemName)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35, height: 35)
                .foregroundColor(currentTab == .mail ? .pink : .gray.opacity(0.7))
                .overlay(alignment: .topTrailing) {
                    Text("\(badge < 100 ? badge : 99)+")
                        .font(.caption.bold())
                        .foregroundColor(scheme == .dark ? .black : .white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 5)
                        .background(.pink, in: Capsule())
                        .background(
                            Capsule()
                                .stroke(scheme == .dark ? .black : .white, lineWidth: 4)
                        )
                        .offset(x: 20, y: -5)
                        .opacity(badge == 0 ? 0 : 1)
                }
                .frame(maxWidth: .infinity)
        }
    }
}

extension TabBarHideView {
    struct CustomTabBar: View {
        @Binding var currentTab: TabItem
        var tabItems: [(name: TabItem, systemName: String)]
        var bottomEdge: CGFloat
        
        
        var body: some View {
            HStack(spacing: 0) {
                ForEach(tabItems, id: \.0) { item in
                    TabBarButton(currentTab: $currentTab, tabItem: item, badge: currentTab == item.name ? 99 : 0)
                }
            }
            .padding(.top, 15)
            .padding(.bottom, bottomEdge)
            .background(.white)
        }
    }
}
