//
//  SafeAreaView+VStack.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/03/09.
//

import SwiftUI

struct SafeAreaView_VStack: View {
    var body: some View {
        VStack {
            Text("Top")
                .border(Color.red, width: 2)
                .background(.blue, ignoresSafeAreaEdges: [])
            
            Spacer()
            
            Text("Bottom")
                .border(Color.red, width: 2)
                .background(.blue, ignoresSafeAreaEdges: [])
        }
        /// do not use padding to prevent extending the safe area.
        /// When applied as below, the spacing occurs.
//        .padding(.init(top: 1, leading: 1, bottom: 1, trailing: 1))
    }
}

struct SafeAreaView_VStack_Previews: PreviewProvider {
    static var previews: some View {
        SafeAreaView_VStack()
    }
}
