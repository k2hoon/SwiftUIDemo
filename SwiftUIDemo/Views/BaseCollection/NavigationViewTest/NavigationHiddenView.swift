//
//  NavigationHiddenView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/11/09.
//

import SwiftUI

struct NavigationHiddenView: View {
    @State var navBarHidden = true
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Color.black)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray
                    .ignoresSafeArea()
                
                NavigationLink(destination: NavigationDetailView(navBarHidden: self.$navBarHidden)) {
                    Text("Go to detail view")
                }
            }
            .navigationTitle("")
            /// Don't use it like this
//            .navigationBarHidden(self.navBarHidden)
        }
        ///  If this method is not used for the navigation view, the initialized setting value is not applied immediately.
        .navigationBarHidden(self.navBarHidden)
        .onAppear(perform: {
            self.navBarHidden = true
        })
    }
}

struct NavigationHiddenView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHiddenView()
    }
}

struct NavigationDetailView: View {
    @Binding var navBarHidden : Bool
    
    var body: some View {
        Text("Hello Detail View!")
            .navigationBarTitle("Detail")
            .onAppear() {
                self.navBarHidden = false
            }
        
    }
}
