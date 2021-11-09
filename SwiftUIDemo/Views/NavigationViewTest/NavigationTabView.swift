//
//  NavigationTabView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/11/09.
//

import SwiftUI

struct NavigationTabView: View {
    enum Tab {
        case view1
        case view2
        case view3
    }
    
    @State var selection: Tab = .view1
    @State var isBarHidden = false
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                NaviTestView()
                    .tabItem { Text("view1") }
                    .tag(Tab.view1)
                NaviTestView1()
                    .tabItem { Text("view2") }
                    .tag(Tab.view2)
                NaviTestView2()
                    .tabItem { Text("view3") }
                    .tag(Tab.view3)
            }
            .navigationBarHidden(self.isBarHidden)
        }
        .onAppear {
            self.isBarHidden = true
        }
    }
}

struct NavigationTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTabView()
    }
}

struct NaviTestView: View {
    var body: some View {
        ZStack {
            Color.red
            
            VStack {
                Text("Hello")
            }
        }
        .hiddenNavigationBar()
    }
}

struct NaviTestView1: View {
    var body: some View {
        ZStack {
            Color.blue
            VStack {
                Text("Hello")
            }
        }
        .hiddenNavigationBar()
    }
}


struct NaviTestView2: View {
    var body: some View {
        ZStack {
            Color.green
            VStack {
//                ScrollView {
//                    ForEach(0..<50) { value in
//                        Text("\(value)")
//                    }
//                }
//                .padding()
                
                List {
                    ForEach(0..<50) { value in
                        Text("\(value)")
                    }
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(PlainListStyle())
                .padding()
            }
        }
        .hiddenNavigationBar()
    }
}
