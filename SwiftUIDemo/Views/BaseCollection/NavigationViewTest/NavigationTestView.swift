//
//  NavigationTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/10/17.
//

import SwiftUI

struct NavigationTestView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray
                    .ignoresSafeArea()
                VStack {
                    Text("Hello")
                        .foregroundColor(.black)
                }
                .navigationTitle(Text("Navigation"))
            }
        }
    }
}

struct NavigationTestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTestView()
    }
}


