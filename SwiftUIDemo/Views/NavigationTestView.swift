//
//  NavigationTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/10/17.
//

import SwiftUI

struct NavigationTestView: View {
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

struct NavigationTestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTestView()
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
