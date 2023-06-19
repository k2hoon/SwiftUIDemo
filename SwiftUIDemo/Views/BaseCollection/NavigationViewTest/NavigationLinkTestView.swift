//
//  NavigationLinkTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/11/09.
//

import SwiftUI

struct NavigationLinkTestView: View {
    @State var isActive = false
    
    var body: some View {
        NavigationView {
            NavigationLink(
                destination: NavigationLinkView1(),
                isActive: $isActive,
                label: {
                    Button(action: { self.isActive.toggle() },
                           label: { Text("Button") })
                })
                .navigationTitle("NavigationView")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NavigationLinkTestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkTestView()
    }
}

// MARK: - Navigation Link Views
struct NavigationLinkView1: View {
    @State var isActive = false
    
    var body: some View {
        NavigationLink(
            destination: NavigationLinkView2(),
            isActive: $isActive,
            label: {
                Button(action: { self.isActive.toggle() },
                       label: { Text("Button") })
            })
            .navigationTitle("NavigationLinkView1 View")
        
    }
}

struct NavigationLinkView2: View {
    @State var isActive = false
    
    var body: some View {
        NavigationLink(
            destination: Text("Destination"),
            isActive: $isActive,
            label: {
                Button(action: { self.isActive.toggle() },
                       label: { Text("Button") })
            })
            .navigationTitle("NavigationLinkView2 View")
    }
}
