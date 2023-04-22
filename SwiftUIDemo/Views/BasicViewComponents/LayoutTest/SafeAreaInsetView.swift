//
//  SafeAreaInsetView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/03/09.
//

import SwiftUI

struct SafeAreaInsetView: View {
    var body: some View {
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
            .ignoresSafeArea()
            .border(.red, width: 1)
            .safeAreaInset(edge: .top, alignment: .center, spacing: 40) {
                Color.clear
                    .frame(height: 30)
                    .background(Material.bar)
            }
            .safeAreaInset(edge: .bottom, alignment: .center, spacing: 50) {
                Color.clear
                    .frame(height: 0)
                    .background(Material.bar)
            }
        }
    }
}

struct SafeAreaInsetView_Previews: PreviewProvider {
    static var previews: some View {
        SafeAreaInsetView()
    }
}
