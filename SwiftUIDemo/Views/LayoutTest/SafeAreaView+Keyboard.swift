//
//  SafeAreaView+Keyboard.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/03/09.
//

import SwiftUI

struct SafeAreaView_Keyboard: View {
    @State private var topSize: CGSize = .zero
    @State private var bottomSize: CGSize = .zero
    @State private var name: String = ""
    
    var body: some View {
        VStack {
            
            Color.blue
                .overlay(Text(verbatim: "\(topSize)"))
//                .frame(height: 200) // this is keyboard avoidance issue.
                .viewSize {
                    topSize = $0
                }
            
            TextField("Name:", text: $name)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.blue.opacity(1.0), lineWidth: 1)
                )
            
            
            Color.cyan
                .overlay(Text(verbatim: "\(bottomSize)"))
//                .frame(height: 200)
                .viewSize {
                    bottomSize = $0
                }
        }
        .padding()
        .ignoresSafeArea(.keyboard)
    }
}

struct SafeAreaView_Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        SafeAreaView_Keyboard()
    }
}
