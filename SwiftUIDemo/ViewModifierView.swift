//
//  ViewModifierView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/07/24.
//

import Foundation
import SwiftUI

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
    
    func borderedCaption() -> some View {
        modifier(BorderedCaption())
    }
    
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}


struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct BorderedCaption: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption2)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 1)
            )
            .foregroundColor(Color.blue)
    }
}

struct ViewModifierView: View {
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
                .watermarked(with: "Using View Modifier")
            VStack {
                Color.black
                    .frame(width: 300, height: 200)
                    .watermarked(with: "Using View Modifier")
                
                Text("Hello world")
                    .modifier(Title())
                
                Text("Hello world")
                    .titleStyle()
                
                Image(systemName: "bus")
                    .resizable()
                    .frame(width:50, height:50)
                    .foregroundColor(.white)
                
                Text("Downtown Bus")
                    .borderedCaption()
            }
        }
    }
}

struct ViewModifierView_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierView()
    }
}

