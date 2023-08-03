//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/03/15.
//

import SwiftUI

struct ContentView: View {
    @State var tabSelection = 0
    @State private var headerHeight: CGFloat = 0
    
    init() {
        Theme.tabBarColors(background: UIColor(Color.white.opacity(0.1)), blurStyle: .systemUltraThinMaterial)
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                TitleView(title: "SwiftUI Demo")
                    .viewSize{ size in self.headerHeight = size.height }
                    .zIndex(1)
                
                TabView(selection: $tabSelection) {
                    BaseView()
                        .tabItem { Label("Base", systemImage: "square.filled.on.square") }
                        .tag(0)
                    
                    
                    GraphicsView()
                        .tabItem { Label("Graphics", systemImage: "star.square.fill") }
                        .tag(1)
                    
                    
                    AdvancedView()
                        .tabItem { Label("Advanced", systemImage: "square.stack.fill") }
                        .tag(2)
                    
                    CoreDataView()
                        .tabItem{ Label("CoreData", systemImage: "exclamationmark.square") }
                        .tag(3)
                }
                .padding(.top, self.headerHeight + 12)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

