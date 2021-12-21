//
//  TabHeaderTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/12/21.
//

import SwiftUI

struct TabHeaderTestView: View {
    @State private var selectedTab: Int = 0
    
    let tabs: [TabHeader] = [
        .init(title: "Tab 1"),
        .init(title: "Tab 2")
    ]
    
    init() {
        //self.setNavigationBarAppearance()
    }
    
    private func setNavigationBarAppearance() {
        let colorApperance = UINavigationBarAppearance()
        colorApperance.configureWithTransparentBackground()
        colorApperance.backgroundColor = UIColor(Color.secondary)
        colorApperance.titleTextAttributes = [.foregroundColor: UIColor.white]
        colorApperance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = colorApperance
        UINavigationBar.appearance().compactAppearance = colorApperance
        UINavigationBar.appearance().scrollEdgeAppearance = colorApperance
    }
    
    var body: some View {
        ZStack {
            // Do not specify a background color,
            // because it overlaps with the color specified in the initialization function.
//            Color.gray
//                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Tabs
                TabHeaderView(fixed: false, tabs: tabs, selectedTab: $selectedTab)
                    .frame(height: 56)
                
                // Views
                TabView(selection: $selectedTab) {
                    TabContentView1().tag(0)
                    TabContentView2().tag(1)
                }
                // using index display mode .never for scroll bounce
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .ignoresSafeArea()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("HeaderTabView Title")
        }
    }
    
    struct TabContentView1: View {
        var body: some View {
            ZStack {
                Color.red200
                    .ignoresSafeArea()
                Text("TabContentView1")
            }
        }
    }

    struct TabContentView2: View {
        var body: some View {
            ZStack {
                Color.green300
                    .ignoresSafeArea()
                Text("TabContentView2")
            }
        }
    }
}

struct TabHeaderTestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TabHeaderTestView()
        }
    }
}
