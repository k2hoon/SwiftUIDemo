//
//  SafeAreaView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/03/06.
//

import SwiftUI

struct SafeAreaView: View {
    var body: some View {
        /// A safe area defines the area within a view that isn’t covered by a navigation bar, tab bar, toolbar, or other views.
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [.blue, .teal],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                Text("Safe Area")
                    .font(.title)
                    .bold()
            }
            .navigationTitle("Hello World")
            .ignoresSafeArea() // this modifier expands the view and fills the space by ignoring the safe area.
            .border(.red, width: 1)
        }
    }
}

struct SafeAreaView_Previews: PreviewProvider {
    static var previews: some View {
        SafeAreaView()
    }
}
