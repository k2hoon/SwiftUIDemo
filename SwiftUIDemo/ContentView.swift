//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/03/15.
//

import SwiftUI
import UIKit

extension UINavigationController: UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

struct ContentView: View {
    @State var tabSelection = 0
    @State private var headerHeight: CGFloat = 0
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearance.backgroundColor = UIColor(Color.white.opacity(0.1))
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        GeometryReader { proxy in
            NavigationView {
                ZStack(alignment: .top) {
                    MainHeaderView()
                        .viewSize{ size in self.headerHeight = size.height }
                        .zIndex(1)
                    
                    TabView(selection: $tabSelection) {
                        BasicView()
                            .tabItem { Label("Basic", systemImage: "square.filled.on.square") }
                            .tag(0)
                        
                        GraphicsView()
                            .tabItem { Label("Graphics", systemImage: "star.square.fill") }
                            .tag(1)
                        
                        AdvancedView()
                            .tabItem { Label("Advanced", systemImage: "square.stack.fill") }
                            .tag(2)
                        
                        TestingView()
                            .tabItem{ Label("Testing", systemImage: "exclamationmark.square") }
                            .tag(3)
                        
                        SettingsView()
                            .tabItem { Label("Settings", systemImage: "gearshape") }
                            .tag(4)
                    }
                    .padding(.top, self.headerHeight + 12)
                }
            }
        }
    }
    
    struct MainHeaderView: View {
        var body: some View {
            HStack {
                Spacer()
                
                Text("SwiftUI Demo")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .kerning(0.5)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .overlay(alignment: .bottom) {
                Divider()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

