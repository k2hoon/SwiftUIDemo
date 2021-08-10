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
        }
        .alert(isPresented: $isShow,
               AlertField(title: AlertField.Title(text: "hello", color: UIColor.white),
                          message: AlertField.Message(text: "world!", color: UIColor.white),
                          background: AlertField.Background(color: UIColor.gray, alpha: 0.7),
                          action: { action in
                                                    
                          }))
    }
}

struct AlertViewTextView_Previews: PreviewProvider {
    static var previews: some View {
        AlertViewTextView()
    }
}
