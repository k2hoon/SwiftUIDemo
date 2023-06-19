//
//  NavigationTabView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/11/09.
//

import SwiftUI

struct NavigationTabView: View {
    enum Tab {
        case tab1
        case tab2
        case tab3
    }
    
    @State var navBarHidden = false
    @State var tabSelection: Tab = .tab1
    
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection) {
                NavigationTabView1(navBarHidden: $navBarHidden)
                    .tabItem { Text("Tab view 1") }
                    .tag(Tab.tab1)
                
                NavigationTabView2(navBarHidden: $navBarHidden)
                    .tabItem { Text("Tab view 2") }
                    .tag(Tab.tab2)
                
                NavigationTabView3(navBarHidden: $navBarHidden)
                    .tabItem { Text("Tab view 3") }
                    .tag(Tab.tab3)
            }
            .navigationTitle(getTabTitle(tab: self.tabSelection))
        }
        .onAppear(perform: {
            self.navBarHidden = true
        })
    }
    
    /// Returns an appropriate title string for each selected tab.
    /// - Parameter tab: tab selection
    /// - Returns: navigation title
    func getTabTitle(tab: Tab) -> String {
        switch tab {
        case .tab1:
            return "NavigationTabView1"
        case .tab2:
            return "NavigationTabView2"
        case .tab3:
            return "NavigationTabView3"
        }
    }
}

struct NavigationTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTabView()
    }
}

struct NavigationTabView1: View {
    @Binding var navBarHidden : Bool
    var body: some View {
        ZStack {
            Color.red
            NavigationLink(destination: NavigationTabDetailView1()) {
                Text("Go to tab detail view")
                    .foregroundColor(.black)
                    .padding()
                    .border(Color.blue)
            }
        }
        .navigationBarHidden(self.navBarHidden)
        .onAppear() {
            print("NavigationTabView2::onAppear")
            self.navBarHidden = false
        }
    }
    
    struct NavigationTabDetailView1: View {
        var body: some View {
            ZStack {
                Color.red
                VStack {
                    Text("Hello")
                }
                .navigationTitle("NavigationTabDetailView1")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}


struct NavigationTabView2: View {
    @Binding var navBarHidden : Bool
    
    var body: some View {
        ZStack {
            Color.blue
            VStack {
                Text("Hello")
            }
        }
        .navigationBarHidden(self.navBarHidden)
        .onAppear() {
            print("NavigationTabView2::onAppear")
            self.navBarHidden = false
        }
    }
}


struct NavigationTabView3: View {
    @Binding var navBarHidden : Bool
    
    var body: some View {
        ZStack {
            Color.green
            List {
                ForEach(0..<50) { value in
                    Text("\(value)")
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(PlainListStyle())
            .padding()
        }
        .navigationBarHidden(self.navBarHidden)
        .onAppear() {
            print("NavigationTabView3::onAppear")
            self.navBarHidden = true
        }
//        .hiddenNavigationBar()
    }
}
