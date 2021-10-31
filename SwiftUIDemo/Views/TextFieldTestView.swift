//
//  TextFieldTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/10/31.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(hint isShow: Bool,
                                    alignment: Alignment = .leading,
                                    @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            self
            placeholder().opacity(isShow ? 1 : 0)   
        }
    }
}

struct TextFieldTestView: View {
    @State var textFieldString = ""
    
    @State var textFieldString2 = ""
    @State var textFieldHint = "Text field hint"
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            
            VStack {
                
                VStack(alignment: .leading) {
                    Text("Enter text the below text field.")
                        .font(.title3)
                        .bold()
                    
                    TextField("this is text field", text: $textFieldString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200, alignment: .center)
                    
                    Text("text field content is: ")
                        .italic()
                    + Text(self.textFieldString)
                }
                
                
                VStack(alignment: .leading) {
                    Text("Enter text the below text field.")
                        .font(.title3)
                        .bold()
                    
                    TextField("", text: $textFieldString2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200, alignment: .center)
                        .placeholder(hint: true) {
                            if self.textFieldString2.isEmpty {
                                Text(self.textFieldHint)
                                    .foregroundColor(.red)
                                    .padding(.leading, 5)
                            }
                        }
                    
                    Text("text field content is: ")
                        .italic()
                    + Text(self.textFieldString2)
                }
                .padding(.top, 20)
                
                
            }
        }
    }
}

struct TextFieldTestView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldTestView()
    }
}
