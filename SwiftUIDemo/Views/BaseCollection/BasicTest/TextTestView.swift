//
//  TextTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/23.
//

import SwiftUI

struct TextTestView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TextDefault()
                    
                    TextTruncate()
                    
                    TextMultiLine()
                    
                    TextLineLimit()
                    
                    VStack {
                        Text("Linespacing text")
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                        
                        Text("Lorem ipsum dolor sit amet, \n consectetur adipiscing elit.")
                            .lineSpacing(10)
                            .padding(.top, 8)
                    }
                }
            }
            .navigationTitle("Text Test")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

struct TextTestView_Previews: PreviewProvider {
    static var previews: some View {
        TextTestView()
    }
}

extension TextTestView {
    struct TextDefault: View {
        var body: some View {
            VStack {
                Text("Default text")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                
                ZStack {
                    Text("Text test")
                        .foregroundColor(.white)
                        .background(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Text test")
                        .foregroundColor(.white)
                        .background(.black)
                    
                    Text("Text test")
                        .foregroundColor(.white)
                        .background(.black)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.top, 8)
                
                Divider()
            }
        }
    }
    
    struct TextTruncate: View {
        let sample = "Lorem ipsum dolor sit amet, consectetur adipiscing elit,"
        
        var body: some View {
            VStack(spacing: 20) {
                Text("Truncated text")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                
                Text(self.sample)
                    .lineLimit(1)
                    .truncationMode(.head)
                    .border(.red)
                
                Text(self.sample)
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .border(.red)
                
                Text(self.sample)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .border(.red)
            }
            Divider()
        }
    }
    
    struct TextMultiLine: View {
        var body: some View {
            VStack(spacing: 20) {
                Text("Multiline text")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                
                Text("multiline \n Text \n Alignment")
                    .multilineTextAlignment(.center)
                    .border(.red)
                
                Text("multiline \n Text \n Alignment")
                    .multilineTextAlignment(.leading)
                    .border(.red)
                
                Text("multiline \n Text \n Alignment")
                    .multilineTextAlignment(.trailing)
                    .border(.red)
            }
            
            Divider()
        }
    }
    
    struct TextLineLimit: View {
        let sample = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        var body: some View {
            VStack {
                Text("Linelimit text")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                
                VStack {
                    Text(self.sample)
                        .lineLimit(2)
                    
                    Divider()
                    
                    Text(self.sample)
                        .lineLimit(nil)
                }
                .padding()
            }
            Divider()
        }
    }
}
