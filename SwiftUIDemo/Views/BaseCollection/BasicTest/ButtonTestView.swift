//
//  ButtonTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/23.
//

import SwiftUI

struct ButtonTestView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ButtonDefault()
                    
                    ButtonBorder()
                    
                    ButtonClipshape()
                    
                    Spacer()
                }
            }
            .navigationTitle("Button Test")
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

struct ButtonTestView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTestView()
    }
}

// MARK: ButtonTestView extension
extension ButtonTestView {
    struct ButtonDefault: View {
        var body: some View {
            VStack {
                Text("Default")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                
                HStack {
                    
                    Button("Button", action: {})
                        .padding()
                    
                    Button("Button", action: {})
                        .padding()
                        .foregroundColor(.white)
                        .background(.blue)
                    
                    Button("Button", action: {})
                        .padding()
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(16)
                }
                
                Divider()
            }
        }
    }
    
    struct ButtonBorder: View {
        var body: some View {
            VStack {
                Text("Button border and stroke")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                
                HStack {
                    Button("Button", action: {})
                        .padding()
                        .foregroundColor(.white)
                        .background(.blue)
                        .border(.red, width: 4)
                    
                    Button(action: {}) {
                        Text("Button")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.red, lineWidth: 4)
                            )
                    }
                    
                    Button(action: {}) {
                        Text("Button")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.red, lineWidth: 4)
                            )
                    }
                }
                
                Divider()
            }
        }
    }
    
    struct ButtonClipshape: View {
        var body: some View {
            VStack {
                Text("Button clipshape")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                
                HStack {
                    Button("Button", action: {})
                        .padding()
                        .foregroundColor(.white)
                        .background(.blue)
                        .clipShape(Capsule())
                    
                    Button("Button", action: {})
                        .padding()
                        .foregroundColor(.white)
                        .background(.blue)
                        .clipShape(Circle())
                }
                
                Divider()
            }
        }
    }
    
}
