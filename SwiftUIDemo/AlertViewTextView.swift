//
//  AlertViewTextView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/08/03.
//

import SwiftUI



struct AlertViewTextView: View {
    @State private var isShow = false
    var body: some View {
        VStack {
            Button(action: {
                self.isShow.toggle()
                
            }, label: {
                Text("Button")
            })
            //AlertControl()
        }
        .alert(isPresented: $isShow)
//        .alert(isPresented: $isShow, content: {
//            Alert(title: Text("OK"))
//            //AlertControl()
//        })
        
    }
}

struct AlertViewTextView_Previews: PreviewProvider {
    static var previews: some View {
        AlertViewTextView()
    }
}
